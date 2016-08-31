module CarManipulations
  extend ActiveSupport::Concern

  def manipulate_by_params(cars, params)
    return cars unless params[:order].present? || params[:q].present?

    if params[:q].present?
      q = params[:q]
      if q[:price_month_gte].present?
        cars = cars.where('price_month >= ?', q[:price_month_gte])
      end
      if q[:price_month_lte].present?
        cars = cars.where('price_month <= ?', q[:price_month_lte])
      end
    end

    if params[:order].present?
      order_attribute = case params[:order][:type]
                          when 'brand'
                            'brands.name'
                          when 'model'
                            'models.name'
                          when 'price'
                            'cars.price_total'
                          else
                            'cars.created_at'
                        end
      order_direction = case params[:order][:direction]
                          when 'asc'
                            'ASC'
                          when 'desc'
                            'DESC'
                          else
                            'DESC'
                        end
      cars = cars.order("#{order_attribute} #{order_direction}")
    end

    cars
  end

end