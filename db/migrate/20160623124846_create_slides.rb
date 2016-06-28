class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :name
      t.integer :slide_template_id

      t.timestamps null: false
    end
  end
end
