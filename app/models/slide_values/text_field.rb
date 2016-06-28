module SlideValues
  class TextField < SlideValue
    include SlideValues::PersistenceTypes::PlainText

    def form_field
      :text_field
    end
  end
end