class AddBestDayDealToCars < ActiveRecord::Migration
  def change
    add_column :cars, :best_day_deal, :boolean
  end
end
