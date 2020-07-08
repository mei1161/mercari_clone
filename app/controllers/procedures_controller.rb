class ProceduresController < ApplicationController
  before_action :authenticate_user!
  def create
    @item = Item.find_by(id: params[:item_id])
    redirect_to item_path(@item) if current_user.id == @item.user_id

    @item.point_buy(current_user) if current_user.point >= @item.price
    redirect_to item_path(@item)
  end

  def show
    @item = Item.find_by(id: params[:item_id])
    @address = current_user.addresses.build
    @addresses = current_user.addresses
  end
end
