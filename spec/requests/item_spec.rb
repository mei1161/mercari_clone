require 'rails_helper'

RSpec.describe 'items', type: :request do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:item) { create(:item, user_id: user.id, category_id: category.id) }
  describe 'items/new' do
    it '新しい出品を作成できること' do
      user.confirm
      sign_in user
      category
      created_item = Item.find(item.id)
      expect(created_item.name).to eq(item.name)
    end
  end
end
