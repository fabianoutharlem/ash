class PageValue < ActiveRecord::Base
  belongs_to :page
  belongs_to :page_template_value

  def field_value
    value
  end

  def field_name
    page_template_value.option_name
  end

  def context
    page_template_value.context || 'Default'
  end

  def form_field
    :text_field
  end

  def partial_name
    'text_field'
  end

  def form_field_options
    {}
  end

end
