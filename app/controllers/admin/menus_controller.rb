class Admin::MenusController < Admin::AdminBaseController

  def index
    @menus = Menu.all
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def update
    @menu = Menu.find(params[:id])
    if @menu.present?
      @menu.update_attributes(slider_params)
      if @menu.valid?
        respond_to do |format|
          format.js { render nothing: true, status: 200 }
          format.html {
            flash['success'] = 'Menu is succesvol aangepast'
            redirect_to :admin_menu
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