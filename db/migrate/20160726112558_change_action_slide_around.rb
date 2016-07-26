class ChangeActionSlideAround < ActiveRecord::Migration
  def change
    Slide.where(slide_template_id: 7).destroy_all
    execute <<-EOF
INSERT INTO `slide_template_values` (`id`, `option_name`, `option_type`, `slide_template_id`, `created_at`, `updated_at`)
VALUES
	(38, 'Slide link', 'SlideValues::TextField', 7, '2016-07-26 13:25:06', '2016-07-26 13:25:06');
    EOF
  end
end
