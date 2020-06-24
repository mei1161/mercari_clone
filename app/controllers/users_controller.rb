class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @items = Item.where(user_id: @user.id).where.not(transaction_status: :draft)
  end

  def drafts
    @drafts = Item.where(user_id: current_user.id).where(transaction_status: :draft)
  end
end
