class CarSaleRequestsController < ApplicationController

  def create
    @car_sale_request = CarSaleRequest.new(car_sale_request_params)

    respond_to do |format|
      if @car_sale_request.save
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  private

  def car_sale_request_params
    params.require(:car_sale_request).permit(:name, :phone, :email, :license_plate, :mileage, :message)
  end
  
end