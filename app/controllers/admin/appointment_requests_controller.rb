class Admin::AppointmentRequestsController < Admin::AdminBaseController

  def index
    @appointment_requests = AppointmentRequest.includes(:car).all.order(created_at: :desc).page(params[:page]).per(25)
  end

  def destroy
    appointment_request = AppointmentRequest.find(params[:id])
    if appointment_request.destroy
      redirect_to :back, notice: 'Afspraak aanvraag is verwijdert'
    else
      redirect_to :back, alert: 'Afspraak aanvraag is niet verwijdert'
    end

  end

end