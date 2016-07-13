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
      nil
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
      @page_graph = Koala::Facebook::API.new('CAAHvZBlZAPcdQBAOp3Rq1SZBJISVyZB9ocs9wwNdel966PjhbZCWBjO8eAp3VbqZBZBZCqRkXvPUSMSxO3mIUo0pYRoUhqh5qvVaM02U6dTaewe2LSbXS2mO3ZBmNZBI437sYMmhy7gz4aH95KdA5JXG5pwl20Sm2T7YqipJPJYhOrZABgihOqqGuUe')
      @page_graph.put_connections('1486194365036244', 'feed', :message => self.display_name, :picture => image_url, :link => car_url(self))
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
                            :"car.mileage" => {
                                :from => "0",
                                :to => (params[:usage].to_i > 0 ? params[:usage].to_i : 2000000).to_i
                            }
                        }
                    },
                    {
                        :range => {
                            :"car.manufacture_year" => {
                                :gte => params[:year].to_i,
                                :lte => "2300"
                            }
                        }
                    }
                ],
                :must_not => [],
                :should => [

                ]
            }
        },
        :from => 0, :size => 999, :sort => [], :facets => {}
    }
    query[:query][:bool][:must] << {
        :query_string => {
            :default_field => "_all",
            :query => params[:query]
        }
    } unless params[:query].blank?


    query[:query][:bool][:must] << {
        :query_string => {
            :default_field => "car.brand.name",
            :query => params[:brand]
        }
    } unless params[:brand].blank?
    query[:query][:bool][:must] <<{
        :query_string => {
            :default_field => "car.model.name",
            :query => params[:model]
        }
    } unless params[:model].blank?

    query[:query][:bool][:must] << {
        :query_string => {
            :default_field => "car.body_type.name",
            :query => params[:type]
        }
    } unless params[:type].blank?
    query[:query][:bool][:must] << {
        :query_string => {
            :default_field => "car.fuel_type.name",
            :query => params[:fuel]
        }
    } unless params[:fuel].blank?
    query[:query][:bool][:must] << {
        :query_string => {
            :default_field => "car.energy_label",
            :query => params[:energy]
        }
    } unless params[:energy].blank?
    query[:query][:bool][:must] << {
        :range => {
            :"car.price_50_50" => {
                :gte => params[:price_range].split('-').first,
                :lte => params[:price_range].split('-').last
            }
        }
    } unless (params[:price_range].blank? or params[:price_range].split('-').length != 2)
    query[:query][:bool][:must] << {
        :range => {
            :"car.price_month" => {
                :gte => params[:monthly_price_range].split('-').first,
                :lte => params[:monthly_price_range].split('-').last
            }
        }
    } unless (params[:monthly_price_range].blank? or params[:monthly_price_range].split('-').length != 2)
    return query
  end


end
