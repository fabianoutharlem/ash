class TransmissionType < ActiveRecord::Base

  has_many :cars

  enum name: {'Automaat' => 'A', 'Handgeschakeld' => 'H', 'Semi-automaat' => 'S'}

end
