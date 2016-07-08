class CreatePagesTable < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :slug
      t.references :page_template
    end
  end
end
