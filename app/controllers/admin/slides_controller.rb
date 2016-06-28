class Admin::SlidesController < Admin::AdminBaseController

  def index
    @slider = Slider.find(params[:slider_id])
    @slides = Slide.slide_includes.where(slider: @slider)
  end

  def new
    @slider = Slider.find(params[:slider_id])
    @slide = Slide.new
    begin
      slide_template = SlideTemplate.find(params[:template_id])
      @slide.slide_template = slide_template if slide_template.present?
      slide_template.slide_template_values.each do |slide_template_value|
        @slide.slide_values << SlideValue.new(slide_template_value: slide_template_value, type: slide_template_value.option_type)
      end
    rescue Exception => e
      Rails.logger.debug e.message
      Rails.logger.debug e.backtrace.join("\n")
      flash[:errors] = 'Het geselecteerde slide template bestaat niet, mocht dit probleem aanhouden neem dan contact op met fabian@oldharlem.nl of mverhaar@merqwaardig.com.'
      redirect_to admin_sliders_path
    end
  end

  def create
    begin
      @slide = Slide.create(slide_params)
      if @slide.valid?
        flash[:notice] = 'Slide is aangemaakt'
        redirect_to admin_slider_slides_path(@slide.slider)
      else
        puts @slide.errors.full_messages
        flash[:error] = @slide.errors.full_messages.to_sentence
        redirect_to :back
      end
    rescue Exception => e
      flash[:error] = 'Er ging iets fout, check je invoer en probeer het nogmaals'
      logger.debug e.message
      redirect_to :back
    end
  end

  def edit
    @slide = Slide.find(params[:id])
  end

  def update
    @slide = Slide.find(params[:id])
    begin
      @slide.update(slide_params)
      if @slide.valid?
        flash[:notice] = 'Slide is aangepast'
        redirect_to admin_slider_slides_path(@slide.slider)
      else
        puts @slide.errors.full_messages
        flash[:error] = @slide.errors.full_messages.to_sentence
        render :edit
      end
    rescue Exception => e
      flash[:error] = 'Er ging iets fout, check je invoer en probeer het nogmaals'
      logger.debug e.message
      logger.debug e.backtrace.join('\n')
      render :edit
    end
  end

  def update_row_order
    @slide = Slide.find(slide_params[:slide_id])
    @slide.row_order_position = slide_params[:row_order_position]
    @slide.save

    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end

  def destroy
    @slide = Slide.find(params[:id])
    if @slide.destroy
      flash[:notice] = 'Slide is verwijderd'
    else
      flash[:error] = 'Slide kon niet verwijderd worden'
    end
    redirect_to admin_slider_slides_path(@slide.slider)
  end

  private

  def slide_params
    params.require(:slide).permit(:id, :slide_id, :name, :slide_template_id, :slider_id, :row_order_position, slide_values_attributes: [:id, :value, :type, :slide_template_value_id, value: []])
  end
  
end