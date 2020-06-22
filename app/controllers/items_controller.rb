class ItemsController < ApplicationController
  before_action :authenticate_user!
  def index
    @items = Item.where(user_id: current_user.id)
    @draft = @items.where(transaction_status: 0)
  end

  def new
    @item = Item.new
    @categories = Category.all
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user

    if params[:draft_submit]
      @item.save(validate: false)
      redirect_to items_path
    elsif params[:submit]
      if @item.save
        redirect_to item_path(@item.id)
      else
        @categories = Category.all
        render 'new'
      end
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
    @categories = Category.all
    @item = Item.find(params[:id])

    if params[:draft_submit]
      @item.update(validate: false)
    elsif params[:submit]
      if @item.update(item_params)
        redirect_to @item
      else
        render 'edit'
      end
    end
  end

  def edit
    @item = Item.find(params[:id])
    @categories = Category.all
  end

  def destroy
    @item = Item.find(params[:id])
    redirect_to items_path if @item.destroy
  end

  private

  def item_params
    params.require(:item).permit(:category_id, :price, :name, :transaction_status, :include_shipping_fee, :text, :item_status, { images: [] })
  end
end
