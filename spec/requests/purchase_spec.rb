require 'rails_helper'

RSpec.describe 'purchases', type: :request do
  let(:user) { create(:user) }
  let(:point_master) { create(:point_master) }

  describe 'post /point/purchase' do
    it 'ポイントの購入ができること' do
      user.confirm
      sign_in user
      expect{ post purchase_path, params:{ point_master_id: point_master.id } }.to change{ user.point }.from(0).to(10000)
    end
  end
end
