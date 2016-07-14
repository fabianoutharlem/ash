class AddVoorraadSettingsLinks < ActiveRecord::Migration
  def change
    Setting.create(name: 'Voorraad banner 1 link', setting: 'cars_banner_1_link', type: 'Settings::TextField')
    Setting.create(name: 'Voorraad banner 2 link', setting: 'cars_banner_2_link', type: 'Settings::TextField')
    Setting.create(name: 'Voorraad banner 3 link', setting: 'cars_banner_3_link', type: 'Settings::TextField')
    Setting.create(name: 'Voorraad banner 4 link', setting: 'cars_banner_4_link', type: 'Settings::TextField')
  end
end
