class CreatePageValues < ActiveRecord::Migration
  def change
    create_table :page_values do |t|
      t.references :page, index: true, foreign_key: true
      t.references :page_template_value, index: true, foreign_key: true
      t.string :value
      t.string :type
    end
  end
end
