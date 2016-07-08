class Vacancy < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  def next
    next_vacancy = Vacancy.where('id > :id', id: self.id).first
    next_vacancy = Vacancy.first if next_vacancy.blank?
    return next_vacancy
  end

end
