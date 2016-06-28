class CreateMarqueeItems < ActiveRecord::Migration
  def change
    create_table :marquee_items do |t|
      t.string :title
      t.string :link

      t.timestamps null: false
    end
  end
end
