class PointHistoriesController < ApplicationController
  before_action :authenticate_user!
  def index
    @point_histories = PointHistory.where(user: current_user)
    pp @point_histories
  end
end