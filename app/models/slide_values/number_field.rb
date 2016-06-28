module SlideValues
  class NumberField < SlideValue
    include SlideValues::PersistenceTypes::PlainText

    def form_field
      :number_field
    end

    def partial_name
      'number_field'
    end
  end
end