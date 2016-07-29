class TopReview < ActiveRecord::Base

  mount_uploader :image, TopReviewUploader

  def self.find_random
    self.where(enabled: true).order('RAND()').limit(1).first
  end

end
