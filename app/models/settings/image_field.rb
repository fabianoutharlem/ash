module Settings
  class ImageField < Setting
    mount_uploader :value, SettingImageUploader

    def partial_name
      'image_field'
    end

    def display_value
      ActionController::Base.helpers.image_tag(self.value.try(:thumb))
    end

    def template_value
      self.value.try(:url)
    end
  end
end