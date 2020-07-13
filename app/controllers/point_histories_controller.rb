class PointHistoriesController < ApplicationController
  before_action :authenticate_user!
  def index
    @point_histories = PointHistory.where(user: current_user)
    @point_now = current_user.point
  end
end
