class CreateSlideTemplateValues < ActiveRecord::Migration
  def change
    create_table :slide_template_values do |t|
      t.string :option_name
      t.string :option_type
      t.integer :slide_template_id

      t.timestamps null: false
    end
  end
end
