module SlideValues
  class ColorField < SlideValue
    include SlideValues::PersistenceTypes::PlainText

    def form_field
      :color_field
    end

    def partial_name
      'color_field'
    end
  end
end