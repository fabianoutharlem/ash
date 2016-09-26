module Admin
  class AdminController < AdminBaseController

    def home
      @newsletter_stats = Newsletter.where.not(campaign_id: nil).order(created_at: :desc).collect(&:get_campaign_statistics).compact
    end

    def clear_cache
      ActiveSupport::Cache::DalliStore.new.clear
      flash[:success] = 'Alle cache entries zijn verwijderd'
      redirect_to :back
    end

  end
end