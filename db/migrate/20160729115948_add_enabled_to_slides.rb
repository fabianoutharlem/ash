class AddEnabledToSlides < ActiveRecord::Migration
  def change
    add_column :slides, :enabled, :boolean
  end
end
