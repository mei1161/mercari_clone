class PurchasesController < ApplicationController
  before_action :authenticate_user!
  def show
    @point_masters = PointMaster.where('started_at <= ?', DateTime.now).where('ended_at >= ?', DateTime.now)
  end

  def create
    @point_master = PointMaster.where('started_at <= ?', DateTime.now).where('ended_at >= ?', DateTime.now).find_by(id: params[:point_master_id])
    unless @point_master.present?
      redirect_to purchase_path, flash: { danger: 'データがないため、購入できません。' }
      return
    end
    @user = current_user
    @user.point += @point_master.amount
    @user.save
    PointPurchaseHistory.create(user: @user, date: DateTime.now, parent_id: params[:point_master_id], point: @point_master.amount)
  end
end
