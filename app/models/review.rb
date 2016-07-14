class Review < ActiveRecord::Base

  scope :approved, -> { where(approved: true) }

  default_scope { order(created_at: :desc) }

end
