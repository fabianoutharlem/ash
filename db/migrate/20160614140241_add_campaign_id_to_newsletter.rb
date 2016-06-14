class AddCampaignIdToNewsletter < ActiveRecord::Migration
  def change
    add_column :newsletters, :campaign_id, :string, after: :id
  end
end
