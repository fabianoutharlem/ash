class Menu < ActiveRecord::Base

  has_many :menu_items

  validates_uniqueness_of :location, :name

end
