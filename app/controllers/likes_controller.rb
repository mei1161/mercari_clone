class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @item = Item.find(params[:id])
    @like = current_user.likes.build(item: @item)
    @like.save
  end
end
