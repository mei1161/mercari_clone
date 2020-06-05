require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:user, name: "" ) }

  describe 'POST #create' do
    it 'createが成功すること' do
      expect do
        post user_registration_path, params: { user: user_params }
      end.to change(User, :count).by 1
    end

    it 'リダイレクトされること' do
      post user_registration_path, params: { user: user_params }
      expect(response).to redirect_to root_url
    end
  end
end
