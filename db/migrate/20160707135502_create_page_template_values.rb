class CreatePageTemplateValues < ActiveRecord::Migration
  def change
    create_table :page_template_values do |t|
      t.string :option_name
      t.string :option_type
      t.string :context
      t.references :page_template, index: true, foreign_key: true
    end
  end
end
