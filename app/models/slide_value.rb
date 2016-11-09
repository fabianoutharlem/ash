class SlideValue < ActiveRecord::Base
  belongs_to :slide, touch: true
  belongs_to :slide_template_value

  def field_value
    value
  end

  def field_name
    slide_template_value.option_name
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
