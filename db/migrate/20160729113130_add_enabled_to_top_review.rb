class AddEnabledToTopReview < ActiveRecord::Migration
  def change
    add_column :top_reviews, :enabled, :boolean, after: :review, default: false
  end
end
