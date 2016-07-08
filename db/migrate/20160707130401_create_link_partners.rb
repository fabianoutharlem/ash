class CreateLinkPartners < ActiveRecord::Migration
  def change
    create_table :link_partners do |t|
      t.text :link

      t.timestamps null: false
    end
  end
end
