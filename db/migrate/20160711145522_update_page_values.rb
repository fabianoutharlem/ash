class UpdatePageValues < ActiveRecord::Migration
  def change
    change_column :page_values, :value, :text
  end
end
