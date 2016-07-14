class AddVoorraadBigBannerToSettings < ActiveRecord::Migration
  def change
    Setting.create(name: 'Voorraad big banner', setting: 'cars_banner_big', type: 'Settings::ImageField')
    Setting.create(name: 'Voorraad big banner link', setting: 'cars_banner_big_link', type: 'Settings::TextField')
  end
end
