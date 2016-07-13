class LinkPartnersController < ApplicationController

  add_breadcrumb 'Link partners'

  def index
    @link_partners = LinkPartner.all
  end

end