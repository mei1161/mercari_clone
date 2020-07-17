class ContactsController < ApplicationController
  before_action :authenticate_user!
  def show
    @item = Item.find(params[:item_id])
    pp @item
    pp current_user
    if current_user.id != @item.user_id
      if current_user.id != @item.buyer_id
        redirect_to item_path(@item)
        return
      end
    end

    if current_user.id == @item.buyer_id
      render 'buyer_contact'
    elsif current_user == @item.user
      render 'owner_contact'
    end
  end
end
