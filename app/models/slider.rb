class Slider < ActiveRecord::Base
  has_many :slides
  has_many :slide_templates
  has_many :active_slides, -> { where(enabled: true) }, class_name: 'Slide'
end
