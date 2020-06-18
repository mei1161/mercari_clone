require 'rails_helper'

RSpec.describe 'items', type: :request do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:item_params) { attributes_for(:item, user_id: user.id, category_id: category.id) }
  let(:item) { create(:item, user_id: user.id, category_id: category.id) }
  let(:invalid_item_params) { attributes_for(:invalid_item_params, user_id: user.id, category_id: category.id) }
  describe 'POST items' do
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

    it '新しい出品の作成に失敗すること' do
      post items_path, params: { item: invalid_item_params }
      failed_item = Item.find_by(name: 'hogehogehoge')
      expect(failed_item).to be_nil
    end
  end

  describe 'items/show' do
    it '詳細ページで画像が確認できる' do
      user.confirm
      sign_in user
      category
      item
      get item_path(id: item.id)
      expect(response.body).to include('img')
    end
  end
end
