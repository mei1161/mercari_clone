require 'rails_helper'

RSpec.describe 'addresses', type: :request do
  let(:user) { create(:user) }
  let(:user2) {create(:user2)}
  let(:category) { create(:category) }
  let(:address) {create(:address, user_id: user.id)}
  let(:item_params) { attributes_for(:item, user_id: user2.id, category_id: category.id) }
  let(:item) { create(:item, user_id: user2.id, category_id: category.id) }
  let(:address_params) { attributes_for(:address, user_id: user.id)}
  let(:invalid_address_params) { attributes_for(:invalid_address_params, user_id: user.id)}
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
      registered_address = user.addresses.find_by(address1: 'address1')
      expect(registered_address).not_to be nil
    end

    it '住所の登録に失敗すること' do
      post add_address_item_procedure_path(item), params: { address: invalid_address_params }
      failed_item = Address.find_by(address1: 'invalid_address1')
      expect(failed_item).to be_nil
    end
  end

end