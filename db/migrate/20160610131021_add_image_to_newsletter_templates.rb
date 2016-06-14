class AddImageToNewsletterTemplates < ActiveRecord::Migration
  def change
    add_column :newsletter_templates, :image, :string, after: :template
  end
end
