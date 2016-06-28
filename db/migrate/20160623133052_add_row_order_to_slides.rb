class AddRowOrderToSlides < ActiveRecord::Migration
  def change
    add_column :slides, :row_order, :integer, after: :name
  end
end
