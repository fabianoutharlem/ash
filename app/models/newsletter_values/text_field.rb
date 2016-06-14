module NewsletterValues
  class TextField < NewsletterValue
    include NewsletterValues::PersistenceTypes::PlainText

    def form_field
      :text_field
    end
  end
end