class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :name
      t.string :email
      t.text :review
      t.integer :rating
      t.boolean :approved, default: false

      t.timestamps null: false
    end
  end
end
