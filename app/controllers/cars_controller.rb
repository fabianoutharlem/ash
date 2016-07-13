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
    render @view
  end

  def compare
    @car_1 = Car.find(params[:car_1_id])
    @car_2 = Car.find(params[:car_2_id])
    @car_3 = Car.find(params[:car_3_id]) if params[:car_3_id].present?

    @equal_options = @car_1.option_list & @car_2.option_list
    @equal_options = @equal_options & @car_3.option_list if @car_3.present?
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

  def favourites
    if cookies[:liked_cars].present?
      likes = JSON.parse cookies[:liked_cars]
    else
      likes = Array.new
    end
    @cars = Car.find(likes)
  end

end


