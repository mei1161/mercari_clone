class ProceduresController < ApplicationController
  before_action :authenticate_user!
  def create
    @item = Item.find(params[:item_id])
    redirect_to item_path(@item) if current_user.id == @item.user_id
    @address = Address.find(params[:address][:id])
    @item.buyer_address_id = @address.id

    if current_user.point >= @item.price
      @item.point_buy(current_user)
      @item.save
    end
    redirect_to item_path(@item)
  end

  def show
    @item = Item.find_by(id: params[:item_id])
    @address = current_user.addresses.build(item_id: @item.id)
  end

  def add_address
    @item = Item.find(params[:item_id])
    @address = current_user.addresses.build(address_params)
    redirect_to item_procedure_path(@item) if @address.save
  end

  private

  def address_params
    params[:address].permit(:id, :zipcode, :prefecture_num, :address1, :address2, :name, :phone_number)
  end
end
