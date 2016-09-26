class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :get_liked_cars

  before_filter :prepare_shared_variables

  add_breadcrumb 'Home', :root_path

  protected

  def get_liked_cars
    if cookies[:liked_cars].present?
      @car_likes = JSON.parse cookies[:liked_cars]
    else
      @car_likes = Array.new
    end
  end

  def prepare_shared_variables

    @menus = Menu.includes(:menu_items).all.inject({}) do |menus, menu|
      menus[menu.location] = menu.menu_items
      menus
    end
    @brands = Brand.includes(:cars).menu_brands.order(:row_order)
  end
end
