require 'rails_helper'

RSpec.describe 'items', type: :request do
  let(:user) { create(:user) }
  let(:user2) {create(:user2)}
  let(:category) { create(:category) }
  let(:address) {create(:address, user_id: user.id)}
  let(:item_params) { attributes_for(:item, user_id: user2.id, category_id: category.id) }
  let(:address) { create(:address, user_id: user.id) }
  let(:address_params) { attributes_for(:address, user_id: user.id)}
  let(:point_master) { create(:point_master) }
  let(:item) { create(:item, user_id: user2.id, category_id: category.id) }
  let(:shipping_item) { create(:shipping_item, user_id: user2.id, category_id: category.id, buyer_id: user.id, buyer_address_id: address.id)}
  let(:evalution) { create(:evalution, user_id: user2.id, evaluted_user_id: user.id, item_id: shipping_item.id )}
  let(:sold_item) { create(:sold_item,user_id: user2.id, category_id: category.id, buyer_id: user.id, buyer_address_id: address.id)}
  let(:evalution_params) { attributes_for(:evalution, user_id: user2.id, evaluted_user_id: user.id) }
  let(:recever_evalution) { attributes_for(:evalution, user_id: user.id, evaluted_user_id: user2.id) }

  describe 'POST procedures' do
    it 'statusをwait_sender_reviewにできる' do
      user.confirm
      user2.confirm
      sign_in user
      category
      item
      address
      post purchase_path, params:{ point_master_id: point_master.id } 
      post item_procedure_path(item),  params: { address: {id: address.id} }
      sign_out user
      sign_in user2
      post change_status_item_contact_path(item)
      item1 = Item.find(item.id)
      expect(item1.transaction_status).to eq('wait_sender_review') 
    end

    it 'statusをwait_recever_reviewにできる' do
      user.confirm
      sign_in user
      shipping_item
      post purchase_path, params:{ point_master_id: point_master.id } 
      post evaluate_user_item_contact_path(shipping_item), params: { evalution: evalution_params }
      pp response.body
      item2 = Item.find(shipping_item.id)
      expect(item2.transaction_status).to eq('wait_recever_review')
    end

    it 'statusをsold_outにできる' do
      user2.confirm
      sign_in user2
      sold_item
      post evaluate_user_item_contact_path(sold_item), params: { evalution: recever_evalution }
      item3 = Item.find(sold_item.id)
      expect(item3.transaction_status).to eq('sold_out')
      owner = User.find(user2.id)
      expect(owner.point).to eq(item3.price)
    end
  end
end