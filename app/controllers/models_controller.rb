class ModelsController < ApplicationController
  include CarManipulations

  add_breadcrumb 'Modellen'

  def cars
    @brand = Brand.find(params[:brand_id])
    @model = @brand.models.find(params[:model_id])
    @cars = @model.cars.includes(:brand, :model)
    @cars = order_by_params(@cars, params).page(params[:page]).per(params[:per_page])

    add_breadcrumb @model.name
    render 'brands/cars'
  end

end