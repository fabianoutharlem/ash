class Model < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :cars
  belongs_to :brand

  validates :name, presence: true
  validates_presence_of :brand
  validates_associated :brand

end
