class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @item = Item.find(params[:id])
    @like = current_user.likes.build(item: @item)
    @like.save
    redirect_to item_path(params[:id])
  end

  def destroy
    @like = current_user.likes.find_by(item_id: params[:id])
    @like.destroy
    redirect_to item_path(params[:id])
  end
end
