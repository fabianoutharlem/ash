class HomeController < ApplicationController

  def index
    @slider = Slider.includes(slides: [:slide_values, :slide_template]).find_by_location('homepage')
    @nieuw_binnen = Car.all.includes(:car_medias, :model, :brand).order(created_at: :desc).limit(32)
  end

end