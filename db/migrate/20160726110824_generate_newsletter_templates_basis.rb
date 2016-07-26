class GenerateNewsletterTemplatesBasis < ActiveRecord::Migration
  def change
    execute <<-EOF
INSERT INTO `newsletter_templates` (`id`, `name`, `template`, `image`, `created_at`, `updated_at`)
VALUES
	(2, 'Auto nieuwsbrief', 'tpl_general', NULL, '2016-07-14 23:07:42', '2016-07-14 23:07:42'),
	(3, 'Auto nieuwsbiref met banner', 'tpl_banner', NULL, '2016-07-26 12:52:47', '2016-07-26 12:52:47');
    EOF

    execute <<-EOF
INSERT INTO `newsletter_template_values` (`id`, `option_name`, `option_type`, `newsletter_template_id`, `created_at`, `updated_at`)
VALUES
	(6, 'autos', 'NewsletterValues::CarsField', 2, '2016-07-26 12:55:55', '2016-07-26 12:55:49'),
	(7, 'tekst', 'NewsletterValues::TextArea', 2, '2016-07-26 12:55:55', '2016-07-26 12:55:49'),
	(8, 'banner', 'NewsletterValues::ImageField', 2, '2016-07-26 12:55:55', '2016-07-26 12:55:49'),
	(10, 'banner_link', 'NewsletterValues::TextField', 2, '2016-07-26 12:55:55', '2016-07-26 12:55:49'),
	(11, 'autos', 'NewsletterValues::CarsField', 3, '2016-07-26 12:55:55', '2016-07-26 12:55:49'),
	(12, 'tekst', 'NewsletterValues::TextArea', 3, '2016-07-26 12:55:55', '2016-07-26 12:55:49'),
	(13, 'banner', 'NewsletterValues::ImageField', 3, '2016-07-26 12:55:55', '2016-07-26 12:55:49'),
	(14, 'banner_link', 'NewsletterValues::TextField', 3, '2016-07-26 12:55:55', '2016-07-26 12:55:49'),
	(15, 'main_banner', 'NewsletterValues::ImageField', 3, '2016-07-26 12:55:55', '2016-07-26 12:55:49'),
	(16, 'main_banner_link', 'NewsletterValues::TextField', 3, '2016-07-26 12:55:55', '2016-07-26 12:55:49');
    EOF
  end
end
