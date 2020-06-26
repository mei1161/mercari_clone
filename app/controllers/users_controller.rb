class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @items = Item.where(user_id: @user.id).where.not(transaction_status: :draft)
  end
end
