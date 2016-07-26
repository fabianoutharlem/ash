module Admin
  class AdminController < AdminBaseController

    def home
      @newsletter_stats = Newsletter.where.not(campaign_id: nil).order(created_at: :desc).collect(&:get_campaign_statistics).compact
    end

  end
end