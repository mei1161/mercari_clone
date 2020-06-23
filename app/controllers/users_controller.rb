class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = current_user
    @items = Item.where(user_id: current_user.id).where.not(transaction_status: 0)
  end

  def drafts
    @drafts = Item.where(user_id: current_user.id).where(transaction_status: 0)
  end
end
