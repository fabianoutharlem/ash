class PagesController < ApplicationController

  def show
    @page = Page.find(params[:id])
    add_breadcrumb @page.title
  end

end