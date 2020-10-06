class StaticPagesController < ApplicationController
  before_action :authenticate_user!
  def mypage
    @user = current_user
  end
end
