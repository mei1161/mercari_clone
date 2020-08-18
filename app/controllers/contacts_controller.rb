class ContactsController < ApplicationController
  before_action :authenticate_user!
  def show
    @item = Item.find(params[:item_id])
    if (current_user.id != @item.user_id) && (current_user.id != @item.buyer_id)
      redirect_to item_path(@item)
      return
    end

    if current_user == @item.user
      user_pattern
    elsif current_user == @item.buyer
      buyer_pattern
    end
  end

  def change_status
    @item = Item.find(params[:item_id])
    @item.transaction_status = :wait_sender_review
    @item.save
    redirect_to item_contact_path(@item)
  end

  def evaluate_user
    @item = Item.find(params[:item_id])
    @evalution = @item.evalutions.build(evalution_params)
    pp evalution_params
    if current_user == @item.buyer
      @item.transaction_status = :wait_recever_review
      redirect_to item_contact_path(@item)
    elsif current_user == @item.user
      @item.transaction_status = :sold_out
      @item.point_transfer
      redirect_to item_contact_path(@item)
    end

    pp @evalution
    pp @item.evalutions
    pp params
    @evalution.save!
    @item.save!
  end

  private

  def buyer_pattern
    case @item.transaction_status
    when 'shipping'
      render 'buyer_wait_sending'
    when 'wait_recever_review'
      render 'buyer_wait_review'
    when 'sold_out'
      render 'transaction_competed'
    else
      render 'buyer_contact'
    end
  end

  def user_pattern
    case @item.transaction_status
    when 'shipping'
      render 'owner_contact'
    when 'wait_recever_review'
      render 'owner_review'
    when 'sold_out'
      render 'transaction_competed'
    else
      render 'owner_wait_review'
    end
  end

  def evalution_params
    params.permit(:status, :text, :user_id, :evaluted_user_id)
  end
end
