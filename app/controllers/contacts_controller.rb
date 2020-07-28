class ContactsController < ApplicationController
  before_action :authenticate_user!
  def show
    @item = Item.find(params[:item_id])
    if (current_user.id != @item.user_id) && (current_user.id != @item.buyer_id)
      redirect_to item_path(@item)
      return
    end

    buyer_pattern
    user_pattern
  end

  def change_status
    @item = Item.find(params[:item_id])
    @item.transaction_status = :wait_sender_review
    @item.save
    redirect_to item_contact_path(@item)
  end

  private

  def buyer_pattern
    if current_user == @item.buyer && @item.transaction_status == 'shipping'
      render 'buyer_wait_sending'
    elsif current_user == @item.buyer
      render 'buyer_contact'
    end
  end

  def user_pattern
    if current_user == @item.user && @item.transaction_status == 'shipping'
      render 'owner_contact'
    elsif current_user == @item.user
      render 'owner_wait_review'
    end
  end
end
