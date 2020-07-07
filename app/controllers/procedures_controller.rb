class ProceduresController < ApplicationController
  def create
    @item = Item.find_by(id: params[:item_id])
    redirect_to item_path(@item) if current_user.id == @item.user_id

    @item.point_buy(current_user) if current_user.point >= @item.price
    redirect_to item_path(@item)
  end

  def show; end
end
