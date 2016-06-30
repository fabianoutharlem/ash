module CarManipulations
  extend ActiveSupport::Concern

  def order_by_params(cars, params)
    return cars unless params[:order].present?
    order_attribute = case params[:order][:type]
                        when 'brand'
                          'brands.name'
                        when 'model'
                          'models.name'
                        when 'price'
                          'cars.price_total'
                        else
                          'cars.price_total'
                      end
    order_direction = case params[:order][:direction]
                        when 'asc'
                          'ASC'
                        when 'desc'
                          'DESC'
                        else
                          'ASC'
                      end
    cars.order("#{order_attribute} #{order_direction}")
  end

end