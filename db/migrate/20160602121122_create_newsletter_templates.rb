class CreateNewsletterTemplates < ActiveRecord::Migration
  def change
    create_table :newsletter_templates do |t|
      t.string :name
      t.string :template

      t.timestamps null: false
    end
  end
end
