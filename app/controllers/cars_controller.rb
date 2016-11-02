class CarsController < ApplicationController
  include CarManipulations

  before_filter :ensure_compare_cars_session

  add_breadcrumb 'Autos', :cars_path

  def index
    @cars = Car.all.includes(:brand, :model)
    @cars = manipulate_by_params(@cars, params).page(params[:page]).per(params[:per_page])
    track_event('cars', 'voorraad bekeken')
  end

  def search
    Car.unscoped do
      @cars = Car.query(params)
    end
    respond_to do |format|
      format.json { render json: {cars: @cars.size} }
      format.html {
        @cars = @cars.includes(:car_images, :brand, :model)
        @cars = manipulate_by_params(@cars, params).page(params[:page]).per(params[:per_page])
        track_event('cars', 'zoek resultaten bekeken')
        render :index
      }
    end
    add_breadcrumb 'Zoeken'
  end

  def add_to_compare_selection
    @car = Car.find(params[:car_id])
    session[:compare_car_ids].push(@car.id)
    session[:compare_car_ids].uniq!
    session[:compare_car_ids] = session[:compare_car_ids].last(3)
    track_event 'cars', 'Auto aan vergelijker toegevoegd', @car.display_name, @car.vehicle_number
    render :update_compare_selection
  end

  def remove_from_compare_selection
    @car = Car.find(params[:car_id])
    session[:compare_car_ids].delete(@car.id)
    track_event 'cars', 'Auto uit vergelijker verwijderd', @car.display_name, @car.vehicle_number
    render :update_compare_selection
  end

  def new_cars
    @cars = Car.includes(:brand, :model).all.limit(36).order(created_at: :desc)
    @cars = manipulate_by_params(@cars, params).page(params[:page]).per(params[:per_page])
    add_breadcrumb 'Nieuw binnen'
    track_event 'cars', 'Nieuw binnen bekeken'
    render :index
  end

  def show
    @car = Car.includes(:brand, :model, :car_images, :options).find(params[:id])
    @view = ab_test('car_show', ['show', 'show_b'])
    @car.increment!(:views)
    track_event 'cars', 'Auto detail bekeken', @car.display_name, @car.vehicle_number
    add_breadcrumb [@car.brand.name, @car.model.name].join(' ')
    render @view
  end

  def compare
    @car_1 = Car.find(params[:car_1_id])
    @car_2 = Car.find(params[:car_2_id])
    @car_3 = Car.find(params[:car_3_id]) if params[:car_3_id].present?

    @equal_options = @car_1.option_list & @car_2.option_list
    @equal_options = @equal_options & @car_3.option_list if @car_3.present?
    track_event 'cars', 'Vergelijker bekeken'
    add_breadcrumb 'Vergelijken'
  end

  def like
    if cookies[:liked_cars].present?
      likes = JSON.parse cookies[:liked_cars]
    else
      likes = Array.new
    end

    likes << params[:car_id]
    cookies[:liked_cars] = likes.uniq.to_json
  end

  def favourites
    if cookies[:liked_cars].present?
      likes = JSON.parse cookies[:liked_cars]
    else
      likes = Array.new
    end
    track_event 'cars', 'Favorieten bekeken'
    @cars = Car.where(slug: likes).order(created_at: :desc)
    add_breadcrumb 'Favorieten'
  end

  def finance_car
    car = Car.find(params[:car_id])
    if car.present?
      converted!('car_show')
      track_event('cars', 'Doorverwezen naar akp met auto', "#{car.display_name} (#{car.vehicle_number})", params[:type])
      redirect_to "http://autokredietplan.nl/cars/finance_ash_car/#{car.vehicle_number_hexon}/#{params[:type]}"
    else
      redirect_to :back
    end
  end

  private

  def ensure_compare_cars_session
    session[:compare_car_ids] ||= []
  end

end


