class PageTemplate < ActiveRecord::Base
  has_many :pages, dependent: :destroy
  has_many :page_template_values, dependent: :destroy
end
