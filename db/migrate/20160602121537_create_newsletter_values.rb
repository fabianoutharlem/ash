class CreateNewsletterValues < ActiveRecord::Migration
  def change
    create_table :newsletter_values do |t|
      t.references :newsletter, index: true, foreign_key: true
      t.references :newsletter_template_value, index: true, foreign_key: true
      t.string :value
      t.string :type

      t.timestamps null: false
    end
  end
end
