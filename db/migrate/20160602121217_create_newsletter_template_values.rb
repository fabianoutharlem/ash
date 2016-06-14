class CreateNewsletterTemplateValues < ActiveRecord::Migration
  def change
    create_table :newsletter_template_values do |t|
      t.string :option_name
      t.string :option_type
      t.references :newsletter_template, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
