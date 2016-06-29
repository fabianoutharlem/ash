class BrandsController < ApplicationController

  def cars
    @brand = Brand.find(params[:brand_id])
    @cars = @brand.cars.includes(:brand, :model).page(params[:page]).per(params[:per_page])
  end

end