require 'rails_helper'

RSpec.describe 'purchases', type: :request do
  let(:user) { create(:user) }
  let(:point_master) { create(:point_master) }

  describe 'post /point/purchase' do
    it 'ポイントの購入ができること' do
      user.confirm
      sign_in user
      post purchase_path, params:{ point_master_id: point_master.id }
      purchased_user = User.find(user.id)
      expect(purchased_user.point).to be > 0
    end
  end
end
