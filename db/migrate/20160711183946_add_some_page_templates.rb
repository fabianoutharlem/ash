class AddSomePageTemplates < ActiveRecord::Migration
  def change
    execute <<-EOF
LOCK TABLES `page_templates` WRITE;
/*!40000 ALTER TABLE `page_templates` DISABLE KEYS */;

INSERT INTO `page_templates` (`id`, `name`, `template`, `created_at`, `updated_at`)
VALUES
	(2,'ASH Exclusief','tpl_exclusief','2016-07-08 16:18:34','2016-07-08 16:18:34'),
	(3,'Budget Cars','tpl_budget_cars','2016-07-11 17:44:35','2016-07-11 17:44:35'),
	(4,'Actie Pagina','tpl_actie_pagina','2016-07-11 18:37:20','2016-07-11 18:37:20');

/*!40000 ALTER TABLE `page_templates` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `page_template_values` WRITE;
/*!40000 ALTER TABLE `page_template_values` DISABLE KEYS */;

INSERT INTO `page_template_values` (`id`, `option_name`, `option_type`, `context`, `page_template_id`, `created_at`, `updated_at`)
VALUES
	(3,'header_title','PageValues::TextField','header',2,NOW(),NOW()),
	(4,'header_onder_title','PageValues::TextField','header',2,NOW(),NOW()),
	(5,'header_image','PageValues::ImageField','header',2,NOW(),NOW()),
	(6,'autos_titel','PageValues::TextField','autos',2,NOW(),NOW()),
	(7,'autos','PageValues::CarsField','autos',2,NOW(),NOW()),
	(8,'autos_link','PageValues::TextField','autos',2,NOW(),NOW()),
	(9,'autos_button_tekst','PageValues::TextField','autos',2,NOW(),NOW()),
	(10,'financier_titel','PageValues::TextField','financieren',2,NOW(),NOW()),
	(11,'financier_onder_titel','PageValues::TextField','financieren',2,NOW(),NOW()),
	(12,'financier_achtergrond','PageValues::ImageField','financieren',2,NOW(),NOW()),
	(13,'text_titel','PageValues::TextField',NULL,2,NOW(),NOW()),
	(14,'text','PageValues::TextArea',NULL,2,NOW(),NOW()),
	(15,'header_logo','PageValues::ImageField','header',3,NOW(),NOW()),
	(16,'header_titel','PageValues::TextField','header',3,NOW(),NOW()),
	(17,'header_onder_titel','PageValues::TextField','header',3,NOW(),NOW()),
	(18,'header_button_tekst','PageValues::TextField','header',3,NOW(),NOW()),
	(19,'header_button_link','PageValues::TextField','header',3,NOW(),NOW()),
	(20,'header_achtergrond','PageValues::ImageField','header',3,NOW(),NOW()),
	(21,'tekst_titel','PageValues::TextField','tekst',3,NOW(),NOW()),
	(22,'tekst_content','PageValues::TextArea','tekst',3,NOW(),NOW()),
	(23,'financieren_titel','PageValues::TextField','financieren',3,NOW(),NOW()),
	(24,'financieren_onder_titel','PageValues::TextField','financieren',3,NOW(),NOW()),
	(25,'financieren_achtergrond','PageValues::ImageField','financieren',3,NOW(),NOW()),
	(26,'header_titel','PageValues::TextField','header',4,NOW(),NOW()),
	(27,'header_onder_titel','PageValues::TextField','header',4,NOW(),NOW()),
	(28,'header_achtergrond','PageValues::ImageField','header',4,NOW(),NOW()),
	(29,'autos','PageValues::CarsField','autos',4,NOW(),NOW()),
	(30,'autos_button_tekst','PageValues::TextField','autos',4,NOW(),NOW()),
	(31,'autos_button_link','PageValues::TextField','autos',4,NOW(),NOW()),
	(32,'zekerheden_titel','PageValues::TextArea','zekerheden',4,NOW(),NOW()),
	(33,'zekerheden_blok_1_logo','PageValues::ImageField','zekerheden',4,NOW(),NOW()),
	(34,'zekerheden_blok_1_titel','PageValues::TextField','zekerheden',4,NOW(),NOW()),
	(35,'zekerheden_blok_1_content','PageValues::TextArea','zekerheden',4,NOW(),NOW()),
	(36,'zekerheden_blok_2_logo','PageValues::ImageField','zekerheden',4,NOW(),NOW()),
	(37,'zekerheden_blok_2_titel','PageValues::TextField','zekerheden',4,NOW(),NOW()),
	(38,'zekerheden_blok_2_content','PageValues::TextArea','zekerheden',4,NOW(),NOW()),
	(39,'zekerheden_blok_3_logo','PageValues::ImageField','zekerheden',4,NOW(),NOW()),
	(40,'zekerheden_blok_3_titel','PageValues::TextField','zekerheden',4,NOW(),NOW()),
	(41,'zekerheden_blok_3_content','PageValues::TextArea','zekerheden',4,NOW(),NOW()),
	(42,'zekerheden_blok_4_logo','PageValues::ImageField','zekerheden',4,NOW(),NOW()),
	(43,'zekerheden_blok_4_titel','PageValues::TextField','zekerheden',4,NOW(),NOW()),
	(44,'zekerheden_blok_4_content','PageValues::TextArea','zekerheden',4,NOW(),NOW()),
	(45,'zekerheden_blok_5_logo','PageValues::ImageField','zekerheden',4,NOW(),NOW()),
	(46,'zekerheden_blok_5_titel','PageValues::TextField','zekerheden',4,NOW(),NOW()),
	(47,'zekerheden_blok_5_content','PageValues::TextArea','zekerheden',4,NOW(),NOW()),
	(48,'review_image','PageValues::ImageField','review',4,NOW(),NOW()),
	(49,'review_quote','PageValues::TextField','review',4,NOW(),NOW()),
	(50,'financieren_titel','PageValues::TextField','financieren',4,NOW(),NOW()),
	(51,'financieren_onder_titel','PageValues::TextField','financieren',4,NOW(),NOW()),
	(52,'financieren_achtergrond','PageValues::ImageField','financieren',4,NOW(),NOW());

/*!40000 ALTER TABLE `page_template_values` ENABLE KEYS */;
UNLOCK TABLES;
    EOF
  end
end
