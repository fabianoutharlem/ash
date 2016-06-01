class Admin::BrandsController < Admin::AdminBaseController

  def index
    @brands = Brand.rank(:row_order).all
  end

  def edit
    @brand = Brand.find(params[:id])
  end

  def update
    @brand = Brand.find(params[:id])
    if @brand.present?
      @brand.update_attributes(brand_params)
      if @brand.valid?
        respond_to do |format|
          format.js { render nothing: true, status: 200 }
          format.html {
            flash['success'] = 'Merk is succesvol aangepast'
            render :edit
          }
        end
      end
    end
  end

  def update_row_order
    @brand = Brand.find(brand_params[:brand_id])
    @brand.row_order_position = brand_params[:row_order_position]
    @brand.save

    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end

  private

  def brand_params
    params.require(:brand).permit(:brand_id, :name, :description, :row_order_position, :visible_in_menu, :image)
  end

end