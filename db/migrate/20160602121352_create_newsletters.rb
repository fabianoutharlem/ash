class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.string :title
      t.string :subject
      t.references :newsletter_template, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
