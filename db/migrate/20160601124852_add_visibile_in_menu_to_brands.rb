class AddVisibileInMenuToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :visible_menu, :boolean, after: :slug
  end
end
