class DraftsController < ApplicationController
  def index
    @drafts = Item.where(user_id: current_user.id).where(transaction_status: :draft)
  end
end
