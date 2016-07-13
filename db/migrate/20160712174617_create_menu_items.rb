class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :name
      t.references :menu, index: true, foreign_key: true
      t.integer :menu_itemable_id
      t.string :menu_itemable_type
      t.integer :row_order

      t.timestamps null: false
    end
  end
end
