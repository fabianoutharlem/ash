module SlideValues
  class ImageField < SlideValue
    include SlideValues::PersistenceTypes::PlainText

    mount_uploader :value, SlideImageUploader

    def form_field
      :image_field
    end

    def partial_name
      'image_field'
    end
  end
end