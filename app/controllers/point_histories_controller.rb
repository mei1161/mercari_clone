class PointHistoriesController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @point_histories = PointHistory.where(user: @user)
    pp @point_histories
  end
end
