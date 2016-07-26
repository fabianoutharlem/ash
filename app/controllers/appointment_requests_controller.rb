class AppointmentRequestsController < ApplicationController

  def create
    @appointment_request = AppointmentRequest.new(appointment_request_params)

    respond_to do |format|
      if @appointment_request.save
        converted!('car_show')
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  private

  def appointment_request_params
    params.require(:appointment_request).permit(:first_name, :last_name, :phone, :email, :comment, :car_id)
  end
  
end