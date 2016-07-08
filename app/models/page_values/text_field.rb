module PageValues
  class TextField < PageValue
    include PageValues::PersistenceTypes::PlainText

    def form_field
      :text_field
    end
  end
end