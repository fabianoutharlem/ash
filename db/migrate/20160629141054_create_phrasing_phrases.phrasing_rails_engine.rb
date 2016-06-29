# This migration comes from phrasing_rails_engine (originally 20120313191745)
class CreatePhrasingPhrases < ActiveRecord::Migration
  def change
    create_table :phrasing_phrases do |t|    
      t.string :locale
      t.string :key
      t.text :value
      t.timestamps
    end
  end
end
