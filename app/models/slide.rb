class Slide < ActiveRecord::Base
  belongs_to :slider
  belongs_to :slide_template
  has_many :slide_values, dependent: :destroy

  accepts_nested_attributes_for :slide_values

  scope :slide_includes, -> { includes(:slide_values, :slide_template) }

  default_scope { order(:row_order) }

  include RankedModel
  ranks :row_order, with_same: :slider_id

  def template_variables
    slide_values.includes(:slide_template_value).index_by { |value| value.slide_template_value.option_name.parameterize.underscore.to_sym }
  end
end
