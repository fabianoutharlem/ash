class Car < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  include Rails.application.routes.url_helpers

  extend FriendlyId

  paginates_per 12

  index_name "ash_cars_#{Rails.env}"

  acts_as_taggable_on :options

  friendly_id :slug_candidates, use: [:slugged, :finders]

  before_destroy :invalidate_cache
  before_update :invalidate_cache

  # TODO: Cache car fragments
  def invalidate_cache
    # ActionController::Base.new.expire_fragment("car_images_#{self.id}")
    # ActionController::Base.new.expire_fragment("admin_car_#{self.id}")
  end

  default_scope { includes(:car_images) }

  def slug_candidates
    [
        :display_name,
        [:display_name, :manufacture_year],
        [:display_name, :mileage]
    ]
  end

  belongs_to :body_type
  belongs_to :fuel_type
  belongs_to :model
  belongs_to :brand
  belongs_to :transmission_type
  has_many :car_medias, dependent: :destroy

  has_many :car_images, -> { where('file_type LIKE ?', '%image%') }, class_name: 'CarMedia'

  enum nap: {true: 'j', false: 'n'}
  enum reserved: {'Gereserveerd' => 'j', 'Niet Gereserveerd' => 'n'}
  enum new: {'Nieuw' => 'j', 'Occasion' => 'n'}
  enum btw_marge: {'BTW' => 'B', 'Marge' => 'M'}

  scope :car_includes, -> { joins(:brand, :model, :body_type, :fuel_type, :transmission_type, :car_medias, :options) }

  scope :week_old, -> { where('cars.created_at >= ?', 1.week.ago.utc).limit(30) }

  validates_associated :model, :brand
  validates :mileage, :color, :engine_size, :manufacture_year, presence: true

  def self.query(params)
    puts build_query(params).to_json
    search = Car.search(build_query(params).to_json)
    if search.results.total
      search.records
    else
      Car.none
    end
  end

  def main_image
    car_medias.first if car_medias.any?
  end

  def display_name
    fields = [brand.name, model.name]
    fields << car_type unless car_type.blank?
    fields.join(' ')
  end

  def related_cars
    Car.tagged_with(option_list, any: true, :order_by_matching_tag_count => true, brand: self.brand).where.not(id: self.id).limit(16)
  end

  def as_indexed_json(options={})
    as_json(
        only: [:id, :display_name, :mileage, :color, :engine_size, :type, :nap, :rdw, :price_total, :price_50_50, :price_month, :manufacture_year, :cylinders, :engine_power, :top_speed, :interior, :energy_label, :road_tax],
        include: [:model, :brand, :body_type, :fuel_type, :transmission_type, :options],
        methods: [:display_name]
    )
  end

  def share_on_facebook(image_url)
    return unless Rails.env.production?
    begin
      @page_graph = Koala::Facebook::API.new('EAAKDDvGWy9EBAIc48zDkOAb7FcavHzQ7LAz9tAXnJ9sc7r26GnrMcuzBrqWKkIkmvJLo9nhpmocZAsanZAahZCYBrWP5pLC63a9VwzHxAZBqEvwJDH9R0IlRzk0L9knXCoCjzcTdHAf5kqQkePzcGT0Sm4SbB4fElatjM0lcTXT9cR5JWEoZB')
      @page_graph.put_connections('226021717452283', 'feed', :message => self.display_name, :picture => image_url, :link => car_url(self))
    rescue Exception => e
      Rails.logger.debug 'The car with id ' + self.id.to_s + ' was not shared on facebook'
      Rails.logger.debug e.message
      Rails.logger.debug e.backtrace
    end
  end

  def self.parse_cardesk_parameters(params)
    brand = Brand.find_or_create_by(name: params[:merk])
    model = Model.find_or_create_by(name: params[:model], brand: brand)
    body = BodyType.find_or_create_by(name: params[:carrosserie])
    fuel = FuelType.find_or_create_by(name: params[:brandstof])
    transmission = TransmissionType.find_or_create_by(name: params[:transmissie])

    options = params[:zoekaccessoires]['accessoire']

    images = params[:afbeeldingen]['afbeelding']

    media = if images.is_a? Array
              images.map do |image_url|
                carmedia = CarMedia.new
                carmedia.remote_file_url = image_url
                carmedia.save!
                carmedia
              end
            elsif images.is_a? String
              carmedia = CarMedia.new
              carmedia.remote_file_url = images
              carmedia.save!
              carmedia
            end


    return {
        vehicle_number: params[:voertuignr],
        vehicle_number_hexon: params[:voertuignr_hexon],
        brand_id: brand.id,
        model_id: model.id,
        transmission_type_id: transmission.id,
        body_type_id: body.id,
        fuel_type_id: fuel.id,
        mileage: params[:tellerstand],
        color: params[:basiskleur],
        color_type: params[:laksoort],
        engine_size: params[:cilinder_inhoud],
        car_type: params[:type],
        nap: params[:nap_weblabel],
        price_total: params[:verkoopprijs_particulier],
        price_month: (params[:lease]['maandbedrag'] rescue nil),
        price_50_50: params[:verkoopprijs_handel],
        price_discount: params[:actieprijs],
        manufacture_year: params[:bouwjaar],
        cylinders: params[:cilinder_aantal],
        engine_power: params[:vermogen_motor_pk],
        top_speed: params[:topsnelheid],
        energy_label: params[:energielabel],
        road_tax: "#{params[:wegenbelasting_kwartaal_min]} / #{params[:wegenbelasting_kwartaal_max]}",
        reserved: params[:gereserveerd],
        new: params[:nieuw],
        btw_marge: params[:btw_marge],
        door_count: params[:aantal_deuren],
        license_plate: params[:kenteken],
        option_list: options,
        car_medias: media
    }
  end

  private

  def self.download_video(url)
    urls = ViddlRb.get_urls(url.gsub('http://', 'https://'))
    carmedia = CarMedia.new
    carmedia.remote_file_url = urls.first
    carmedia.save!
    carmedia
  end

  def self.build_query(params)
    query = {
        :query => {
            :bool => {
                :must => [
                    {
                        :range => {
                            :"mileage" => {
                                :gte => "0",
                                :lte => (params[:mileage].to_i > 0 ? params[:mileage].to_i : 2000000).to_i
                            }
                        }
                    },
                    {
                        :range => {
                            :"manufacture_year" => {
                                :gte => params[:manufacture_year_from].to_i,
                                :lte => params[:manufacture_year_to].to_i > 0 ? params[:manufacture_year_to].to_i : Date.today.year
                            }
                        }
                    }
                ],
                :must_not => [],
                :should => [

                ],
                minimum_should_match: 1,
            }
        },
        :from => 0, :size => 999, :sort => []
    }
    query[:query][:bool][:must] << {
        :query_string => {
            :default_field => "_all",
            :query => params[:query]
        }
    } unless params[:query].blank?


    query[:query][:bool][:must] << {
        :query_string => {
            :default_field => "brand.id",
            :query => params[:brand_id]
        }
    } unless params[:brand_id].blank?
    query[:query][:bool][:must] <<{
        :query_string => {
            :default_field => "model.id",
            :query => params[:model_id]
        }
    } unless params[:model_id].blank?

    query[:query][:bool][:must] << {
        :query_string => {
            :default_field => "body_type.id",
            :query => params[:body_type_id]
        }
    } unless params[:body_type_id].blank?
    query[:query][:bool][:must] << {
        :query_string => {
            :default_field => "fuel_type.id",
            :query => params[:fuel_type_id]
        }
    } unless params[:fuel_type_id].blank?
    query[:query][:bool][:must] << {
        :query_string => {
            :default_field => "energy_label",
            :query => params[:energy]
        }
    } unless params[:energy].blank?

    query[:query][:bool][:must] << {
        :query_string => {
            :default_field => "transmission_type.id",
            :query => params[:transmission_type_id]
        }
    } unless params[:transmission_type_id].blank?

    query[:query][:bool][:should] << {
        :range => {
            :"price_total" => {
                :gte => 0,
                :lte => params[:total_price].to_i
            }
        }
    } unless params[:total_price].blank?
    query[:query][:bool][:should] << {
        :range => {
            :"price_month" => {
                :gte => 0,
                :lte => params[:month_price].to_i
            }
        }
    } unless params[:month_price].blank?
    return query
  end


end
