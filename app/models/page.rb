class Page < ActiveRecord::Base
  belongs_to :page_template
  has_many :page_values, dependent: :destroy

  has_many :menu_items, dependent: :nullify, foreign_key: :menu_itemable_id
  has_many :settings, dependent: :nullify, foreign_key: :value

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

  def template_variables
    page_values.includes(:page_template_value).index_by { |value| value.page_template_value.option_name.parameterize.underscore.to_sym }
  end

  def menu_item_properties
    [
        self.title,
        {class: self.class.name, id: self.id}.to_json
    ]
  end

  def route
    Rails.application.routes.url_helpers.page_path(self)
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
