class CarsController < ApplicationController
  include CarManipulations

  def index
    @cars = Car.all.includes(:brand, :model)
    @cars = order_by_params(@cars, params).page(params[:page]).per(params[:per_page])
  end

  def search

  end

  def show
    @car = Car.includes(:brand, :model, :car_images, :options).find(params[:id])
    @view = ab_test('car_show', ['show', 'show_b'])
    # render @view
  end

  def like
    if cookies[:liked_cars].present?
      likes = JSON.parse cookies[:liked_cars]
    else
      likes = Array.new
    end

    likes << params[:car_id]
    cookies[:liked_cars] = likes.uniq.to_json
    render nothing: true
  end

end


