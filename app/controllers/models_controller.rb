class ModelsController < ApplicationController
  include CarManipulations

  def cars
    @brand = Brand.find(params[:brand_id])
    @model = @brand.models.find(params[:model_id])
    @cars = @model.cars.includes(:brand, :model)
    @cars = order_by_params(@cars, params).page(params[:page]).per(params[:per_page])
    render 'brands/cars'
  end

end