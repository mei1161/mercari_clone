class ItemsController < ApplicationController
  before_action :authenticate_user!
  def new
    @item = Item.new
    @categories = Category.all
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      pp 'success'
      redirect_to item_path(@item.id)
    else
      pp 'failed'
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:category_id, :price, :name, :transaction_status, :include_shipping_fee, :text, :item_status)
  end
end
