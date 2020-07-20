class ContactsController < ApplicationController
  before_action :authenticate_user!
  def show
    @item = Item.find(params[:item_id])
    if (current_user.id != @item.user_id) && (current_user.id != @item.buyer_id)
      redirect_to item_path(@item)
      return
    end

    render 'buyer_contact' if current_user == @item.buyer
    render 'owner_contact' if current_user == @item.user

  end

  def change_status
    @item = Item.find(params[:item_id])
    @item.transaction_status = :wait_sender_review
    @item.save
  end
end
