class CreateTopReviews < ActiveRecord::Migration
  def change
    create_table :top_reviews do |t|
      t.string :image
      t.text :review

      t.timestamps null: false
    end
  end
end
