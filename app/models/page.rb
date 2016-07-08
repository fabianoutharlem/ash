class Page < ActiveRecord::Base
  belongs_to :page_template
  has_many :page_values

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

  accepts_nested_attributes_for :page_values

  scope :page_includes, -> { includes(:page_values, :page_template) }

  def template_values
    values = {}
    page_values.each do |page_value|
      hash = {
          page_value.field_name.to_sym => page_value.field_value
      }
      values.merge! hash
    end
    values
  end

  private

  def slug_candidates
    [
        :title,
        [:title, :id]
    ]
  end

  def should_generate_new_friendly_id?
    title_changed?
  end

end
