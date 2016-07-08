class PageTemplate < ActiveRecord::Base
  has_many :pages
  has_many :page_template_values
end
