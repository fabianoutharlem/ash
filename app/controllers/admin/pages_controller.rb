class Admin::PagesController < Admin::AdminBaseController

  def index
    @pages = ::Page.page_includes.all
  end

  def new
    @page = ::Page.new
    begin
      page_template = ::PageTemplate.find(params[:template_id])
      @page.page_template = page_template if page_template.present?
      page_template.page_template_values.each do |page_template_value|
        @page.page_values << ::PageValue.new(page_template_value: page_template_value, type: page_template_value.option_type)
      end
    rescue Exception => e
      Rails.logger.debug e.message
      Rails.logger.debug e.backtrace
      flash[:errors] = 'The selected page template does not exist, therefore we were not able to show a page form. Please try again.'
      redirect_to admin_pages_path
    end
  end

  def create
    begin
      @page = ::Page.create(page_params)
      if @page.valid?
        flash[:notice] = 'Page created successfully'
        redirect_to admin_pages_path
      else
        puts @page.errors.full_messages
        flash[:error] = @page.errors.full_messages.to_sentence
        render :new
      end
    rescue Exception => e
      flash[:error] = 'Something went wrong, please check the data and try again'
      logger.debug e.message
      redirect_to new_admin_page_path
    end
  end

  def edit
    @page = ::Page.find(params[:id])
  end

  def update
    @page = ::Page.find(params[:id])
    begin
      @page.update(page_params)
      if @page.valid?
        flash[:notice] = 'Page has been updated'
        redirect_to admin_pages_path
      else
        puts @page.errors.full_messages
        flash[:error] = @page.errors.full_messages.to_sentence
        render :edit
      end
    rescue Exception => e
      raise e
      flash[:error] = 'Something went wrong, please check the data and try again'
      logger.debug e.message
      logger.debug e.backtrace
      render :edit
    end
  end

  def destroy
    if ::Page.find(params[:id]).destroy
      flash[:notice] = 'Page has been deleted'
    else
      flash[:error] = 'Page could not be deleted'
    end
    redirect_to admin_pages_path
  end

  private

  def page_params
    params.require(:page).permit(:id, :title, :meta_title, :meta_description, :page_template_id, :row_order_position, page_values_attributes: [:id, :value, :type, :page_template_value_id])
  end

end