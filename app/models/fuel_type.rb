class FuelType < ActiveRecord::Base

  has_many :cars

  enum name: {diesel: 'D', benzine: 'B', gas: 'G', hybride: 'H', 'LPG G3' => '3'}

  def display_name
    name.capitalize
  end

end
