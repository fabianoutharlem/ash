class AlterBestDayDeal < ActiveRecord::Migration
  def change
    change_column_default :cars, :best_day_deal, false
  end
end
