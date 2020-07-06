class ProcedureController < ApplicationController
  def create
    @item = Item.find(params[:id])
    redirect_to item_path(@item) if current_user.id == @item.user_id

    if current_user.point >= @item.price
      @item.point_buy(current_user, @item)
    else
      redirect_to item_path(@item)
    end
  end

  def show; end
end
