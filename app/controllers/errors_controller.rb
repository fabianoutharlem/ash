class ErrorsController < ApplicationController

  def show
    status_code = params[:code] || 500
    add_breadcrumb status_code.to_s
    render status_code.to_s, status: status_code
  end

end