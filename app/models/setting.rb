class Setting < ActiveRecord::Base

  def partial_name
    'text_field'
  end

  def display_value
    self.value
  end

  def to_partial_path
    'settings/setting'
  end

  def template_value
    self.value
  end

  def self.get(setting_name)
    self.find_by_setting(setting_name).try(:template_value)
  end
end
