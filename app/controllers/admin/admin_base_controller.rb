module Admin
  class AdminBaseController < ApplicationController

    layout 'admin/layouts/application'

    before_action :authenticate_user!

    private

  end
end