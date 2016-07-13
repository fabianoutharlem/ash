class CreateMenuRecords < ActiveRecord::Migration
  def change
    execute <<-EOF
INSERT INTO `menus` (`id`, `name`, `location`, `created_at`, `updated_at`)
VALUES
	(1, 'Hoofdmenu', 'head_menu', '2016-07-12 21:35:54', '2016-07-12 21:35:54'),
	(2, 'Submenu Blok 1', 'sub_menu_1', '2016-07-13 14:33:57', '2016-07-13 14:33:57'),
	(3, 'Submenu Blok 2', 'sub_menu_2', '2016-07-13 14:33:57', '2016-07-13 14:33:57'),
	(4, 'Submenu Blok 3', 'sub_menu_3', '2016-07-13 14:33:57', '2016-07-13 14:33:57');
    EOF
  end
end
