class AddSliderToSlideTemplates < ActiveRecord::Migration
  def change
    add_reference :slide_templates, :slider, index: true, foreign_key: true

    slider_1 = Slider.find_by_location('homepage')
    slider_2 = Slider.find_by_location('home_action')
    SlideTemplate.where(id: [1,2,3,4,5,6]).update_all(slider_id: slider_1.id)
    SlideTemplate.find(7).update(slider_id: slider_2.id)

  end
end
