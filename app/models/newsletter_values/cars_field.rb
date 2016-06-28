module NewsletterValues
  class CarsField < NewsletterValue
    include NewsletterValues::PersistenceTypes::Array

    serialize :value

    def cars
      Car.find(value.reject(&:blank?)) if value.present? && value.any? rescue Car.none
    end

    def form_field
      :text_field
    end

    def partial_name
      'cars_field'
    end
  end
end