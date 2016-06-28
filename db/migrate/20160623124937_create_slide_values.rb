class CreateSlideValues < ActiveRecord::Migration
  def change
    create_table :slide_values do |t|
      t.integer :slide_id
      t.integer :slide_template_value_id
      t.string :value
      t.string :type

      t.timestamps null: false
    end
  end
end
