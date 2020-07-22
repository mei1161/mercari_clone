require 'rails_helper'

RSpec.describe 'addresses', type: :request do
  let(:user) { create(:user) }
  let(:user2) {create(:user2)}
  let(:category) { create(:category) }
  let(:address) {create(:address, user_id: user.id)}
  let(:item_params) { attributes_for(:item, user_id: user2.id, category_id: category.id) }
  let(:item) { create(:item, user_id: user2.id, category_id: category.id) }
  let(:address_params) { attributes_for(:address, user_id: user.id)}
  describe 'POST address' do
    it '新しく住所を登録できること' do
      user.confirm
      user2.confirm
      sign_in user
      category
      item
      get item_path(item)
      get item_procedure_path(item)
      post add_address_item_procedure_path(item), params: { address: address_params }
      address1 = Address.where(user_id: user.id)
      pp address1
      post item_procedure_path(item), params: { address: address1 }
    end
  end

end