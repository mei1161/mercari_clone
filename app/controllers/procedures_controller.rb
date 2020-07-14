class ProceduresController < ApplicationController
  before_action :authenticate_user!
  def create
    @item = Item.find_by(id: params[:item_id])
    
    if params[:address][:id]
      @address = Address.find(params[:address][:id])
    else
      @address.save
    end

    redirect_to item_path(@item) if current_user.id == @item.user_id

    @item.point_buy(current_user) if current_user.point >= @item.price
    redirect_to item_path(@item)
  end

  def show
    @item = Item.find_by(id: params[:item_id])
    @address = current_user.addresses.build(item_id: @item.id)
  end

  def add_address
    @address = current_user.addresses.build(address_params)
    if @address.save
  end

  private

  def address_params
    params[:address].permit(:id, :zipcode, :prefecture_num, :address1, :address2, :name, :phone_number)
  end
end
