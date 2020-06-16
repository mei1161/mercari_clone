class ItemsController < ApplicationController
  before_action :authenticate_user!
  def new
    @item = Item.new
    @categories = Category.all
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    redirect_to item_path(@item.id) if @item.save
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:category_id, :price, :name, :transaction_status, :include_shipping_fee, :text, :item_status, { images: [] })
  end
end
