class CarsController < ApplicationController

  def index
    @cars = Car.all.includes(:brand, :model).page(params[:page]).per(params[:per_page])
  end

  def search

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


