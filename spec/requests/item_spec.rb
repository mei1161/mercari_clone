require 'rails_helper'

RSpec.describe 'items', type: :request do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:item_params) { attributes_for(:item, user_id: user.id, category_id: category.id) }
  let(:item) { create(:item, user_id: user.id, category_id: category.id) }
  let(:invalid_item_params) { attributes_for(:invalid_item_params, user_id: user.id, category_id: category.id) }
  let(:change_item_params) { attributes_for(:item, price: 17_000) }
  let(:draft_item_params) { attributes_for(:item, transaction_status: 'draft') }
  let(:invalid_changed_item_params) { attributes_for(:item, price: 200) }
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

  describe 'PATCH /items' do
    it '出品の更新ができる' do
      user.confirm
      sign_in user
      category
      item
      patch item_path(item.id), params: { item: change_item_params }
      updated_item = Item.find(item.id)
      expect(updated_item.price).to eq(17_000)
    end

    it 'パラメータが間違えている場合更新ができない' do
      patch item_path(item.id), params: { item: invalid_changed_item_params }
      failed_item = Item.find(item.id)
      expect(failed_item.price).not_to eq(200)
    end
  end

  describe 'delete /items' do
    it 'アイテムの削除ができる' do
      user.confirm
      sign_in user
      category
      item
      delete item_path(item.id)
      deleted_item = Item.find_by(name: 'hoge')
      expect(deleted_item).to be_nil
    end
  end

  describe 'edit/item draft' do
    it 'アイテムを下書きで保存するとitems/showが見えなくなる' do
      user.confirm
      sign_in user
      category
      item
      get item_path(item.id)
      pp response
      expect(response).to have_http_status 200
    end
  end
end
