class StaticPagesController < ApplicationController

  def contact
  end

  def financieringen
  end

  def particuliere_financieringen
  end

  def zakelijke_financieringen
  end

  def deals_50_50
    render '50_50_deals'
  end

  def disclaimer
  end

end