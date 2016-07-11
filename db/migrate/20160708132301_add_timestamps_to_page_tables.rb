class AddTimestampsToPageTables < ActiveRecord::Migration
  def change
    change_table(:pages) { |t| t.timestamps }
    change_table(:page_values) { |t| t.timestamps }
    change_table(:page_templates) { |t| t.timestamps }
    change_table(:page_template_values) { |t| t.timestamps }
  end
end
