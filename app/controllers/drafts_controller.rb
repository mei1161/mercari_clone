class DraftsController < ApplicationController
  before_action :authenticate_user!
  def index
    @drafts = current_user.items.where(transaction_status: :draft)
  end

  def show
    @item = current_user.items.find(params[:id])
  end
end
