module Settings
  class TextArea < Setting

    def partial_name
      'text_area'
    end

    def display_value
      ActionController::Base.helpers.truncate(ActionController::Base.helpers.strip_tags(value), length: 80)
    end
  end
end