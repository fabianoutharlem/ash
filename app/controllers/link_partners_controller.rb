class LinkPartnersController < ApplicationController

  def index
    @link_partners = LinkPartner.all
  end

end