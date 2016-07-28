class Settings::CheckboxField < Setting

  def value
    ActiveRecord::Type::Boolean.new.type_cast_from_database(super)
  end

  def partial_name
    'checkbox_field'
  end

  def display_value
    self.value == true ? 'Aan' : 'Uit'
  end

end