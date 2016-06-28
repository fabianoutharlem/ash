class AddSliderIdToSlides < ActiveRecord::Migration
  def change
    add_reference :slides, :slider, index: true, foreign_key: true, after: :row_order
  end
end
