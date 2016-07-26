class Admin::AbTestsController < Admin::AdminBaseController

  def index
    @tests = SimpleAbs::Alternative.all.group_by(&:experiment)
  end

end