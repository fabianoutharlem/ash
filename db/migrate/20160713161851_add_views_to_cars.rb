class AddViewsToCars < ActiveRecord::Migration
  def change
    add_column :cars, :views, :integer, before: :created_at
  end
end
