class ItemsController < ApplicationController
  before_action :authenticate_user!
  def index
    @items = Item.where.not(transaction_status: :draft)
  end

  def new
    @item = Item.new
    @categories = Category.all
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user

    if params[:draft_submit]
      @item.assign_attributes(transaction_status: :draft)
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
      @item.assign_attributes(item_params)
      @item.assign_attributes(transaction_status: :draft)
      @item.save(validate: false)
      redirect_to @item
    elsif @item.update(item_params)
      redirect_to @item
    else
      render 'edit'
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
