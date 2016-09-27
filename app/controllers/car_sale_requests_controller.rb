class CarSaleRequestsController < ApplicationController

  def create
    @car_sale_request = CarSaleRequest.new(car_sale_request_params)
    if verify_recaptcha(model: @car_sale_request) && @car_sale_request.save
      redirect_to :back
    else
      redirect_to root_path
    end
  end

  private

  def car_sale_request_params
    params.require(:car_sale_request).permit(:name, :phone, :email, :license_plate, :mileage, :message)
  end

end