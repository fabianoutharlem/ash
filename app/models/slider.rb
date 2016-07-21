class Slider < ActiveRecord::Base
  has_many :slides
  has_many :slide_templates
end
