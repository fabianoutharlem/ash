class Admin::CarsController < Admin::AdminBaseController

  def index
    @cars = Car.all.includes(:brand, :model).page(params[:page])
  end

  def best_day_deals
    @cars = Car.where(best_day_deal: true).includes(:brand, :model).page(params[:page])
  end

  def search
    query = params[:q]
    query = "%#{query}%"
    @cars = Car.joins(:brand, :model).where('vehicle_number_hexon LIKE :q OR car_type LIKE :q OR brands.name LIKE :q OR models.name LIKE :q OR replace(license_plate, \'-\', \'\') LIKE replace(:q, \'-\', \'\')', q: query).page(params[:page])
    respond_to do |format|
      format.js {
        render json: {
            cars: @cars.map {|car|
              {
                  id: car.id,
                  display_name: car.display_name,
                  main_image_url: car.main_image.try(:file).try(:small).try(:url)
              }
            },
            total_count: @cars.total_count,
            page: @cars.current_page
        }, status: 200
      }
      format.html
    end
  end

  def update
    @car = Car.find(params[:id])
    if @car.present?
      @car.update_attributes(car_params)
      if @car.valid?
        respond_to do |format|
          format.js { render nothing: true, status: 200 }
          format.html
        end
      end
    end
  end

  def destroy
    car = Car.find(params[:id])
    car.destroy!
    redirect_to admin_cars_path
  end

  private

  def car_params
    params.require(:car).permit(:id, :best_day_deal)
  end

end