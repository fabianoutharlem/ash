class AddPriceDiscountToCars < ActiveRecord::Migration
  def change
    add_column :cars, :price_discount, :decimal, after: :price_total
  end
end
