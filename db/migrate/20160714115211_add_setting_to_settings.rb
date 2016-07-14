class AddSettingToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :setting, :string, after: :name
  end
end
