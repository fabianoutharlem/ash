class Newsletter < ActiveRecord::Base
  belongs_to :newsletter_template
  has_many :newsletter_values, dependent: :destroy

  accepts_nested_attributes_for :newsletter_values

  scope :newsletter_includes, -> { includes(:newsletter_values, :newsletter_template) }

  def self.get_lists
    gibbon = Gibbon::Request.new
    lists = gibbon.lists.retrieve
    lists = lists['lists']
    lists.map do |list|
      [
          "#{list['name']} (#{list['stats']['member_count']})",
          list['id']
      ]
    end
  end

  def create_campaign(list_id)
    gibbon = Gibbon::Request.new
    recipients = {
        list_id: list_id
    }
    settings = {
        subject_line: self.subject,
        title: self.title,
        from_name: 'Auto Service Haarlem',
        reply_to: 'info@autoservicehaarlem.nl'
    }

    body = {
        type: "regular",
        recipients: recipients,
        settings: settings
    }

    begin
      response = gibbon.campaigns.create(body: body)
      update!(campaign_id: response['id'])
      self.update_campaign
      self.send_campaign
    rescue Gibbon::MailChimpError => e
      puts "Houston, we have a problem: #{e.message} - #{e.raw_body}"
      raise e
    end
  end

  def update_campaign
    gibbon = Gibbon::Request.new
    body = {
        html: self.generate_html,
    }
    begin
      response = gibbon.campaigns(self.campaign_id).content.upsert(body: body)
      puts response.inspect
    rescue Gibbon::MailChimpError => e
      puts "Houston, we have a problem: #{e.message} - #{e.raw_body}"
      raise e
    end
  end

  def send_campaign
    gibbon = Gibbon::Request.new
    gibbon.campaigns(self.campaign_id).actions.send.create
  end

  def generate_html
    ApplicationController.new.render_to_string(template: 'admin/newsletters/templates/' + self.newsletter_template.template, locals: template_variables, layout: false)
  end

  def template_variables
    newsletter_values.includes(:newsletter_template_value).index_by { |value| value.newsletter_template_value.option_name.to_sym }
  end

  def get_campaign_statistics
    gibbon = Gibbon::Request.new
    gibbon.campaigns(self.campaign_id).retrieve rescue nil
  end

end
