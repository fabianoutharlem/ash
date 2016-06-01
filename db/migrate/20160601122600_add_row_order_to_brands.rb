class AddRowOrderToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :row_order, :integer, after: :description
  end
end
