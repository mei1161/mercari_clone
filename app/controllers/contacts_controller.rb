class ContactsController < ApplicationController
  before_action :authenticate_user!
  def show
    @item = Item.find(params[:item_id])
    if (current_user.id != @item.user_id) && (current_user.id != @item.buyer_id)
      redirect_to item_path(@item)
      return
    end

    if current_user == @item.buyer && @item.transaction_status == 'shipping'
      render 'buyer_wait_sending'
    elsif current_user == @item.buyer
      render 'buyer_contact'
    end
    render 'owner_contact' if current_user == @item.user
  end

  def change_status
    @item = Item.find(params[:item_id])
    @item.transaction_status = :wait_sender_review
    @item.save
  end
end
