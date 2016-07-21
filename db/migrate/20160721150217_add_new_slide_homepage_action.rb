class AddNewSlideHomepageAction < ActiveRecord::Migration
  def change
    slider = Slider.create(name: 'Homepage actie slider', location: 'home_action')
    actie_slide = SlideTemplate.create(name: 'Foto Slide', template: 'tpl_image_slide')
    SlideTemplateValue.create(option_name: 'Slide Image', option_type: 'SlideValues::ImageField', slide_template: actie_slide)
  end
end
