class AddVoorraadSettings < ActiveRecord::Migration
  def change
    Setting.create(name: 'Voorraad banner 1', setting: 'cars_banner_1', type: 'Settings::ImageField')
    Setting.create(name: 'Voorraad banner 2', setting: 'cars_banner_2', type: 'Settings::ImageField')
    Setting.create(name: 'Voorraad banner 3', setting: 'cars_banner_3', type: 'Settings::ImageField')
    Setting.create(name: 'Voorraad banner 4', setting: 'cars_banner_4', type: 'Settings::ImageField')
  end
end
