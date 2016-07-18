class AddSlide6 < ActiveRecord::Migration
  def change
    execute <<-EOF
INSERT INTO `slide_templates` (`id`, `name`, `template`, `created_at`, `updated_at`)
VALUES
	(6, 'Icon slide', 'tpl_icon_slide', '2016-07-18 13:59:01', '2016-07-18 13:59:01');
    EOF

    execute <<-EOF
INSERT INTO `slide_template_values` (`id`, `option_name`, `option_type`, `slide_template_id`, `created_at`, `updated_at`)
VALUES
	(33, 'Background', 'SlideValues::ImageField', 6, '2016-07-18 13:59:39', '2016-07-18 13:59:39'),
	(34, 'Header titel', 'SlideValues::TextField', 6, '2016-07-18 14:00:02', '2016-07-18 14:00:02'),
	(35, 'Icons', 'SlideValues::ImageField', 6, '2016-07-18 14:00:21', '2016-07-18 14:00:21'),
	(36, 'Sub heading', 'SlideValues::TextField', 6, '2016-07-18 14:00:48', '2016-07-18 14:00:48');
    EOF
  end
end
