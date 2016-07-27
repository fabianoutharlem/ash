class AddTopReviewAndZekerhedenSettings < ActiveRecord::Migration
  def change
    Setting.create(name: 'Zekerheden zichtbaar op auto pagina', setting: 'zekerheden_car_show_visible', type: 'Settings::CheckboxField')
    Setting.create(name: 'Zekerheden zichtbaar op merken pagina', setting: 'zekerheden_brands_visible', type: 'Settings::CheckboxField')
    Setting.create(name: 'Top review zichtbaar op auto pagina', setting: 'top_review_car_show_visible', type: 'Settings::CheckboxField')
    Setting.create(name: 'Top review zichtbaar op merker pagina', setting: 'top_review_brands_visible', type: 'Settings::CheckboxField')
  end
end
