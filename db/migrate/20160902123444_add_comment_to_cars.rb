class AddCommentToCars < ActiveRecord::Migration
  def change
    add_column :cars, :comment, :text
  end
end
