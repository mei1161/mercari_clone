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
    current_user.point_purchase(@point_master)
  end
end
