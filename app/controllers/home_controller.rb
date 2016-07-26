class HomeController < ApplicationController

  def index
    @slider = Slider.includes(slides: [:slide_values, :slide_template]).find_by_location('homepage')
    @actie_slider = Slider.includes(slides: [:slide_values, :slide_template]).find_by_location('home_action')
    @nieuw_binnen = Car.all.includes(:car_medias, :model, :brand).order(created_at: :desc).limit(32)
  end

end