class BrandsController < ApplicationController
  include CarManipulations

  def cars
    @brand = Brand.find(params[:brand_id])
    @cars = @brand.cars.includes(:brand, :model)
    @cars = order_by_params(@cars, params).page(params[:page]).per(params[:per_page])
  end

end