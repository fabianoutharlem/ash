module NewsletterValues
  class NumberField < NewsletterValue
    include NewsletterValues::PersistenceTypes::PlainText

    def form_field
      :number_field
    end

    def partial_name
      'number_field'
    end
  end
end