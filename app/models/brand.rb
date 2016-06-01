class Brand < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  include RankedModel
  ranks :row_order

  has_many :cars
  has_many :models, dependent: :destroy

  mount_uploader :image, BrandImageUploader

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.all_for_menu
    distinct.joins(:cars).group('brands.id').having('count(cars.id) > ?', 0).order('name asc')
  end

end
