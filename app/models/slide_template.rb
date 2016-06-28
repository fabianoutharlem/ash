class SlideTemplate < ActiveRecord::Base
  has_many :slides
  has_many :slide_template_values
end
