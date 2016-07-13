module ApplicationHelper
  def is_active_controller(controller_name)
    params[:controller] == controller_name ? "active" : nil
  end

  def is_active_action(action_name)
    params[:action] == action_name ? "active" : nil
  end

  def format_money(amount)
    if amount.nil?
      amount = 0.0
    end
    string = number_to_currency(amount, unit: '€ ', delimiter: '.', separator: ',')
    string.gsub(',00', ',-')
  end

  def is_active_url(url)
    url == request.path ? "active" : nil
  end

end
