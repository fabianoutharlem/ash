module NewsletterValues
  class ImageField < NewsletterValue
    include SlideValues::PersistenceTypes::PlainText

    mount_uploader :value, NewsletterImageUploader

    def form_field
      :image_field
    end

    def partial_name
      'image_field'
    end
  end
end