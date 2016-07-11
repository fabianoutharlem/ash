module PageValues
  class ImageField < PageValue
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