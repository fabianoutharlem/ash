module NewsletterValues
  class CheckBox < NewsletterValue
    include NewsletterValues::PersistenceTypes::PlainText

    def form_field
      :check_box
    end

    def partial_name
      'check_box'
    end

    def value
      ActiveRecord::Type::Boolean.new.type_cast_from_database(super)
    end
  end
end