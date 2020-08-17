class EvalutionsController < ApplicationController
  def index
    @evalutions = Evalution.find_by(user_id: params[:user_id])
  end

  def create
  end

end
