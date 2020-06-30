class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @item = Item.find_by(id: params[:item_id])
    @comment = current_user.comments.build(comment_params)
    @comment.save
    redirect_to item_path(@item)
  end

  def destroy
    @comment = current_user.comments.find_by(item_id: params[:id])
    @comment.destroy
    redirect_to item_path(params[:id])
  end

  private

  def comment_params
    params.permit(:text, :item_id, :user_id)
  end
end
