class Admin::CarSaleRequestsController < Admin::AdminBaseController

  def index
    @car_sale_requests = CarSaleRequest.all.order(created_at: :desc).page(params[:page]).per(25)
  end

  def destroy
    car_sale_request = CarSaleRequest.find(params[:id])
    if car_sale_request.destroy
      redirect_to :back, notice: 'Taxatie aanvraag is verwijdert'
    else
      redirect_to :back, alert: 'Taxatie aanvraag is niet verwijdert'
    end

  end

end