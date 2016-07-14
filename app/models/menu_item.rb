class MenuItem < ActiveRecord::Base
  belongs_to :menu
  belongs_to :menu_itemable, polymorphic: true

  delegate :location, to: :menu

  include RankedModel
  ranks :row_order, with_same: :menu_id

  default_scope { order(:row_order) }

  MENU_ITEMABLE_CLASSES = [Page, Link]

  def self.menu_item_records
    records = MENU_ITEMABLE_CLASSES.inject({}) do |memo, klass|
      memo[klass.name] = klass.all.map &:menu_item_properties
      memo
    end
    records
  end

  def route
    menu_itemable.try(:route)
  end

end
