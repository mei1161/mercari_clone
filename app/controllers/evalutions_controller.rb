class EvalutionsController < ApplicationController
  def index
    @evalutions = Evalution.where(user_id: params[:user_id])
  end
end
