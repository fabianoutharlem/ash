class NewsletterValue < ActiveRecord::Base
  belongs_to :newsletter
  belongs_to :newsletter_template_value

  def field_value
    value
  end

  def field_name
    newsletter_template_value.option_name
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
