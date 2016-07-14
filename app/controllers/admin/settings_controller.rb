class Admin::SettingsController < Admin::AdminBaseController

  def index
    @settings = Setting.all.order(:name)
  end
  
  def edit
    @setting = Setting.find(params[:id])
  end

  def update
    @setting = Setting.find(params[:id])
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to admin_settings_path, notice: 'Setting is aangepast.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def setting_params
    params.require(:setting).permit(:id, :value)
  end

end