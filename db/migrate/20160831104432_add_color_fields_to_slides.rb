class AddColorFieldsToSlides < ActiveRecord::Migration
  def change
    execute <<-EOF
INSERT INTO `slide_template_values` (`id`, `option_name`, `option_type`, `slide_template_id`, `created_at`, `updated_at`)
VALUES
	(39, 'Knop kleur', 'SlideValues::ColorField', 1, '2016-08-31 10:27:51', '2016-08-31 10:27:54'),
	(40, 'Tekst kleur', 'SlideValues::ColorField', 1, '2016-08-31 10:28:59', '2016-08-31 10:29:00'),
	(41, 'Tekst kleur', 'SlideValues::ColorField', 5, '2016-08-31 10:31:21', '2016-08-31 10:31:22'),
	(42, 'Tekst kleur', 'SlideValues::ColorField', 6, '2016-08-31 10:34:08', '2016-08-31 10:34:09'),
	(43, 'Tekst kleur', 'SlideValues::ColorField', 4, '2016-08-31 10:40:43', '2016-08-31 10:40:53'),
	(44, 'Knop kleur', 'SlideValues::ColorField', 4, '2016-08-31 10:40:51', '2016-08-31 10:40:53');
    EOF
  end
end
