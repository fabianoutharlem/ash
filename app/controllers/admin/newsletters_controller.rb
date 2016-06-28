class Admin::NewslettersController < Admin::AdminBaseController

  def index
    @newsletters = Newsletter.newsletter_includes.all.order('created_at DESC').page(params[:page])
  end

  def prepare_for_send
    @newsletter = Newsletter.find(params[:newsletter_id])
  end

  def send_newsletter
    @newsletter = Newsletter.find(params[:newsletter_id])
    if @newsletter.present? && params[:list_id].present?
      @newsletter.create_campaign(params[:list_id])
      flash[:notice] = 'De nieuwsbrief is verstuurd'
      redirect_to :admin_newsletters
    end
  end

  def new
    @newsletter = Newsletter.new
    begin
      newsletter_template = NewsletterTemplate.find(params[:template_id])
      @newsletter.newsletter_template = newsletter_template if newsletter_template.present?
      newsletter_template.newsletter_template_values.each do |newsletter_template_value|
        @newsletter.newsletter_values << NewsletterValue.new(newsletter_template_value: newsletter_template_value, type: newsletter_template_value.option_type)
      end
    rescue Exception => e
      Rails.logger.debug e.message
      Rails.logger.debug e.backtrace.join("\n")
      flash[:errors] = 'Het geselecteerde nieuwsbrief template bestaat niet, mocht dit probleem aanhouden neem dan contact op met fabian@oldharlem.nl of mverhaar@merqwaardig.com.'
      redirect_to admin_newsletters_path
    end
  end

  def create
    begin
      @newsletter = Newsletter.create(newsletter_params)
      if @newsletter.valid?
        flash[:notice] = 'Nieuwsbrief is aangemaakt'
        redirect_to admin_newsletters_path
      else
        puts @newsletter.errors.full_messages
        flash[:error] = @newsletter.errors.full_messages.to_sentence
        render :new
      end
    rescue Exception => e
      flash[:error] = 'Er ging iets fout, check je invoer en probeer het nogmaals'
      logger.debug e.message
      redirect_to :back
    end
  end

  def edit
    @newsletter = Newsletter.find(params[:id])
  end

  def update
    @newsletter = Newsletter.find(params[:id])
    begin
      @newsletter.update(newsletter_params)
      if @newsletter.valid?
        flash[:notice] = 'Nieuwsbrief is aangepast'
        redirect_to admin_newsletters_path
      else
        puts @newsletter.errors.full_messages
        flash[:error] = @newsletter.errors.full_messages.to_sentence
        render :edit
      end
    rescue Exception => e
      flash[:error] = 'Er ging iets fout, check je invoer en probeer het nogmaals'
      logger.debug e.message
      logger.debug e.backtrace.join('\n')
      render :edit
    end
  end

  def preview
    @newsletter = Newsletter.find(params[:newsletter_id])
  end

  def destroy
    if Newsletter.find(params[:id]).destroy
      flash[:notice] = 'Nieuwsbrief is verwijderd'
    else
      flash[:error] = 'Niewsbrief kon niet verwijderd worden'
    end
    redirect_to admin_newsletters_path
  end

  private

  def newsletter_params
    params.require(:newsletter).permit(:id, :title, :subject, :newsletter_template_id, :row_order_position, newsletter_values_attributes: [:id, :value, :type, :newsletter_template_value_id, value: []])
  end
  
end