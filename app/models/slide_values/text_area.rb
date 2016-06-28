module SlideValues
  class TextArea < SlideValue
    include SlideValues::PersistenceTypes::PlainText

    def form_field
      :text_area
    end

    def partial_name
      'text_area'
    end
  end
end