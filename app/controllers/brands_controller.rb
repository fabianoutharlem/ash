class BrandsController < ApplicationController
  include CarManipulations

  add_breadcrumb 'Merken'

  def cars
    @brand = Brand.find(params[:brand_id])
    @cars = @brand.cars.includes(:brand, :model)
    @cars = order_by_params(@cars, params).page(params[:page]).per(params[:per_page])

    add_breadcrumb @brand.name
  end

  def models
    @brand = Brand.find(params[:brand_id])
    @models = @brand.models.order(:name)
    respond_to do |format|
      format.json {
        render json: @models
      }
    end
  end

end