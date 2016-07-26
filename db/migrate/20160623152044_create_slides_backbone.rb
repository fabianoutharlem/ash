class CreateSlidesBackbone < ActiveRecord::Migration
  def change
    execute <<-EOF
INSERT INTO `slide_template_values` (`id`, `option_name`, `option_type`, `slide_template_id`, `created_at`, `updated_at`)
VALUES
	(1,'Heading','SlideValues::TextField',1,'2016-06-23 13:47:20','2016-06-23 13:48:14'),
	(2,'Knop tekst','SlideValues::TextField',1,'2016-06-23 13:47:55','2016-06-23 13:48:14'),
	(3,'Knop link','SlideValues::TextField',1,'2016-06-23 14:07:41','2016-06-23 14:08:07'),
	(4,'Achtergrond','SlideValues::ImageField',1,'2016-06-23 13:48:12','2016-06-23 13:48:14'),
	(5,'Heading','SlideValues::TextField',2,'2016-06-23 14:28:09','2016-06-23 14:28:46'),
	(6,'Autos','SlideValues::CarsField',2,'2016-06-23 14:28:23','2016-06-23 14:28:46'),
	(7,'Button tekst','SlideValues::TextField',2,'2016-06-23 14:28:36','2016-06-23 14:28:46'),
	(8,'Button link','SlideValues::TextField',2,'2016-06-23 14:28:44','2016-06-23 14:28:46'),
	(9,'Heading','SlideValues::TextField',3,'2016-06-23 14:32:26','2016-06-23 14:34:21'),
	(10,'Sub Heading','SlideValues::TextField',3,'2016-06-23 14:32:34','2016-06-23 14:34:21'),
	(11,'Cirkel 1 heading','SlideValues::TextField',3,'2016-06-23 14:32:47','2016-06-23 14:34:21'),
	(12,'Cirkel 1 sub heading','SlideValues::TextField',3,'2016-06-23 14:32:56','2016-06-23 14:34:21'),
	(13,'Cirkel 1 button tekst','SlideValues::TextField',3,'2016-06-23 14:33:06','2016-06-23 14:34:21'),
	(14,'Cirkel 1 button link','SlideValues::TextField',3,'2016-06-23 14:33:13','2016-06-23 14:34:21'),
	(15,'Cirkel 2 heading','SlideValues::TextField',3,'2016-06-23 14:33:21','2016-06-23 14:34:21'),
	(16,'Cirkel 2 sub heading','SlideValues::TextField',3,'2016-06-23 14:33:31','2016-06-23 14:34:21'),
	(17,'Cirkel 2 knop tekst','SlideValues::TextField',3,'2016-06-23 14:33:41','2016-06-23 14:34:21'),
	(18,'Cirkel 2 knop link','SlideValues::TextField',3,'2016-06-23 14:33:50','2016-06-23 14:34:21'),
	(19,'Cirkel 3 heading','SlideValues::TextField',3,'2016-06-23 14:33:58','2016-06-23 14:34:21'),
	(20,'Cirkel 3 sub heading','SlideValues::TextField',3,'2016-06-23 14:34:05','2016-06-23 14:34:21'),
	(21,'Cirkel 3 knop tekst','SlideValues::TextField',3,'2016-06-23 14:34:12','2016-06-23 14:34:21'),
	(22,'Cirkel 3 knop link','SlideValues::TextField',3,'2016-06-23 14:34:19','2016-06-23 14:34:21'),
	(23,'Logo','SlideValues::ImageField',4,'2016-06-23 14:41:02','2016-06-23 14:41:40'),
	(24,'Heading','SlideValues::TextField',4,'2016-06-23 14:41:10','2016-06-23 14:41:40'),
	(25,'Sub heading','SlideValues::TextField',4,'2016-06-23 14:41:17','2016-06-23 14:41:40'),
	(26,'Button tekst','SlideValues::TextField',4,'2016-06-23 14:41:30','2016-06-23 14:41:40'),
	(27,'Button link','SlideValues::TextField',4,'2016-06-23 14:41:39','2016-06-23 14:41:40'),
	(28,'Heading','SlideValues::TextField',5,'2016-06-23 14:42:41','2016-06-23 14:43:03'),
	(29,'Sub heading','SlideValues::TextField',5,'2016-06-23 14:42:49','2016-06-23 14:43:03'),
	(30,'Background','SlideValues::ImageField',5,'2016-06-23 14:43:02','2016-06-23 14:43:03'),
	(31,'Background','SlideValues::ImageField',3,'2016-06-23 14:43:21','2016-06-23 14:43:27'),
	(32,'Background','SlideValues::ImageField',4,'2016-06-23 14:43:45','2016-06-23 14:43:48');
EOF

    execute <<-EOF
INSERT INTO `slide_templates` (`id`, `name`, `template`, `created_at`, `updated_at`)
VALUES
	(1,'Actie Slide','tpl_action_slide','2016-06-23 13:48:14','2016-06-23 13:48:14'),
	(2,'Cars slide','tpl_cars_slide','2016-06-23 14:28:46','2016-06-23 14:28:46'),
	(3,'Financieren slide','tpl_finance_slide','2016-06-23 14:34:21','2016-06-23 14:34:21'),
	(4,'Logo slide','tpl_logo_slide','2016-06-23 14:41:40','2016-06-23 14:41:40'),
	(5,'Geen button slide','tpl_no_button_slide','2016-06-23 14:43:03','2016-06-23 14:43:03');
EOF

    execute <<-EOF
INSERT INTO `sliders` (`id`, `name`, `location`, `created_at`, `updated_at`)
VALUES
	(1,'Homepage Slider','homepage','2016-06-23 15:18:16','2016-06-23 13:27:32');
    EOF
  end
end
