class NewsletterTemplate < ActiveRecord::Base
  has_many :newsletters
  has_many :newsletter_template_values

  mount_uploader :image, NewsletterTemplateUploader
end
