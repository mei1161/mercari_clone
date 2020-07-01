class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @comment = current_user.comments.find_by(item_id: params[:id])
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.permit(:text, :item_id, :user_id)
  end
end
