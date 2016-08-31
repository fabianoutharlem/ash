class AddKnopTekstKleurToSliders < ActiveRecord::Migration
  def change
    execute <<-EOF
INSERT INTO `slide_template_values` (`id`, `option_name`, `option_type`, `slide_template_id`, `created_at`, `updated_at`)
VALUES
	(45, 'Knop tekst kleur', 'SlideValues::ColorField', 1, '2016-08-31 10:48:55', '2016-08-31 10:48:58'),
	(46, 'Knop tekst kleur', 'SlideValues::ColorField', 4, '2016-08-31 10:49:11', '2016-08-31 10:49:13');
    EOF
  end
end
