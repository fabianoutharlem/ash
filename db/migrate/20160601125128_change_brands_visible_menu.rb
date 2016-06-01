class ChangeBrandsVisibleMenu < ActiveRecord::Migration
  def change
    rename_column :brands, :visible_menu, :visible_in_menu
    change_column_default :brands, :visible_in_menu, false
  end
end
