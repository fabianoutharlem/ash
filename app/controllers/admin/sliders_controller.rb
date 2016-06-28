class Admin::SlidersController < Admin::AdminBaseController

  def index
    @sliders = Slider.all
  end

  def edit
    @slider = Slider.find(params[:id])
  end

  def update
    @slider = Slider.find(params[:id])
    if @slider.present?
      @slider.update_attributes(slider_params)
      if @slider.valid?
        respond_to do |format|
          format.js { render nothing: true, status: 200 }
          format.html {
            flash['success'] = 'Slider is succesvol aangepast'
            redirect_to :admin_sliders
          }
        end
      end
    end
  end

  private

  def slider_params
    params.require(:slider).permit(:id, :name)
  end

end