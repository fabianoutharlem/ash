class Admin::MenuItemsController < Admin::AdminBaseController

  before_filter :split_menu_itemable_params, only: [:create, :update]

  def index
    @menu = Menu.find(params[:menu_id])
    @menu_items = MenuItem.where(menu: @menu)
  end

  def new
    @menu = Menu.find(params[:menu_id])
    @menu_item = MenuItem.new
  end

  def create
    begin
      @menu_item = MenuItem.create(menu_item_params)
      if @menu_item.valid?
        flash[:notice] = 'Menu Item is aangemaakt'
        redirect_to admin_menu_menu_items_path(@menu_item.menu)
      else
        puts @menu_item.errors.full_messages
        flash[:error] = @menu_item.errors.full_messages.to_sentence
        redirect_to :back
      end
    rescue Exception => e
      flash[:error] = 'Er ging iets fout, check je invoer en probeer het nogmaals'
      logger.debug e.message
      redirect_to :back
    end
  end

  def edit
    @menu_item = MenuItem.find(params[:id])
  end

  def update
    @menu_item = MenuItem.find(params[:id])
    begin
      @menu_item.update(menu_item_params)
      if @menu_item.valid?
        flash[:notice] = 'Menu Item is aangepast'
        redirect_to admin_menu_menu_items_path(@menu_item.menu)
      else
        puts @menu_item.errors.full_messages
        flash[:error] = @menu_item.errors.full_messages.to_sentence
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
    @menu_item = MenuItem.find(menu_item_params[:menu_item_id])
    @menu_item.row_order_position = menu_item_params[:row_order_position]
    @menu_item.save

    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end

  def destroy
    @menu_item = MenuItem.find(params[:id])
    if @menu_item.destroy
      flash[:notice] = 'Menu Item is verwijderd'
    else
      flash[:error] = 'Menu Item kon niet verwijderd worden'
    end
    redirect_to admin_menu_menu_items_path(@menu_item.menu)
  end

  private

  def split_menu_itemable_params
    if params[:menu_item][:menu_itemable].present?
      menu_itemable_params = params[:menu_item].delete(:menu_itemable)
      menu_itemable = JSON.parse(menu_itemable_params)
      puts menu_itemable.inspect
      params[:menu_item][:menu_itemable_type] = menu_itemable['class']
      params[:menu_item][:menu_itemable_id] = menu_itemable['id']
    end
  end

  def menu_item_params
    params.require(:menu_item).permit(:id, :name, :menu_id, :menu_item_id, :row_order_position, :menu_itemable_type, :menu_itemable_id)
  end

end