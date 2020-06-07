require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }
  # invalid_userをFactoryBotに追加する
  # このコメントは削除してください
  let(:invalid_user) { create(:invlaid_user) }
  let(:invalid_user_params) { attributes_for(:invalid_user) }
  # change_user_params を作成する
  let(:change_user_params) { attributes_for(:user, name: 'hoge', current_password: 'password', password_confirmation: 'password') }

  describe 'POST /users' do
    it 'ユーザーの作成が成功すること' do
      expect do
        post user_registration_path, params: { user: user_params }
        expect(response).to redirect_to root_url
      end.to change(User, :count).by 1
    end
    it 'ユーザーの作成が失敗すること' do
    end
  end

  describe 'DELETE /users/sign_out' do
    it 'ログアウトできること' do
      sign_in user
      delete destroy_user_session_path
      expect(response).to redirect_to root_url
    end

    it 'リダイレクトされること' do
      get root_path
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'POST /users/sign_in' do
    it 'ログインできること' do
      user
      post user_session_path, params: { user: user_params }
      expect(response).to redirect_to root_url
    end
    it 'ログインできないこと' do
      post user_session_path, params: { user: invalid_user_params }
      expect(response).to have_http_status 200
    end
  end

  describe 'PATCH /users' do
    it 'プロフィールの変更ができること' do
      sign_in user
      put user_registration_path, params: { user: change_user_params }
      changed_user = User.find_by(email: user.email)
      expect(changed_user.name).to eq('hoge')
    end
  end

  describe 'DELETE /users' do
    it 'ユーザーの削除ができること' do
      sign_in user
      delete user_registration_path
      deleted_user = User.find_by(email: user.email)
      expect(deleted_user).to be_nil
    end
  end
end
