require 'rails_helper'

RSpec.describe 'items', type: :request do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:item_params) { attributes_for(:item, user_id: user.id, category_id: category.id) }
  let(:item) { create(:item, user_id: user.id, category_id: category.id) }
  describe 'items/new' do
    it '新しい出品を作成できること' do
      user.confirm
      sign_in user
      category
      post items_path, params: { item: item_params }
      created_item = Item.find_by(name: item.name)
      expect(created_item.name).to eq(item.name)
      expect(created_item.category.name).to eq(category.name)
      expect(created_item.user.name).to eq(user.name)
    end
  end
end
