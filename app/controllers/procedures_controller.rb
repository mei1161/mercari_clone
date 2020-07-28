class ProceduresController < ApplicationController
  before_action :authenticate_user!
  def create
    @item = Item.find(params[:item_id])
    redirect_to item_path(@item) if current_user.id == @item.user_id
    @address = current_user.addresses.find(params[:address][:id])
    if @item.buyer.present?
      redirect_to item_path(@item)
      return
    end

    @item.buyer_address = @address

    if current_user.point < @item.price
      redirect_to item_path(@item)
      return
    end
    @item.point_buy(current_user)
    @item.save
    redirect_to item_contact_path(@item)
  end

  def show
    @item = Item.find(params[:item_id])
    @address = current_user.addresses.build
  end

  def add_address
    @item = Item.find(params[:item_id])
    @address = current_user.addresses.build(address_params)
    @address.save
    redirect_to item_procedure_path(@item)
  end

  private

  def address_params
    params[:address].permit(:id, :zipcode, :prefecture_num, :address1, :address2, :name, :phone_number)
  end
end
