class StaticPagesController < ApplicationController

  def contact
    add_breadcrumb 'Contact'
  end

  def financieringen
    add_breadcrumb 'Financieringen'
  end

  def particuliere_financieringen
    add_breadcrumb 'Particuliere financieringen'
  end

  def zakelijke_financieringen
    add_breadcrumb 'Zakelijke financieringen'
  end

  def deals_50_50
    add_breadcrumb '50/50 Deals'
    render '50_50_deals'
  end

  def disclaimer
    add_breadcrumb 'Disclaimer'
  end

  def site_map
    add_breadcrumb 'Sitemap'
  end

end