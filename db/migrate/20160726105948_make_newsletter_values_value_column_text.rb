class MakeNewsletterValuesValueColumnText < ActiveRecord::Migration
  def change
    change_column :newsletter_values, :value, :text
  end
end
