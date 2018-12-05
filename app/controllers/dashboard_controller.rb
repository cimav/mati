class DashboardController < ApplicationController
  before_action :auth_required

  def index
  	@activity_logs = ActivityLog.all.order("id DESC").limit(20).reverse
  end
end
