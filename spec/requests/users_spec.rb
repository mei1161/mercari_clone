require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:invalid_user) }
  let(:change_user_params) { attributes_for(:user, name: 'hoge', current_password: 'password', biography: 'hogehoge', birthday: Date.parse('2019-02-10')) }

  describe 'POST /users' do
    it 'ユーザーの作成が成功すること' do
      expect do
        post user_registration_path, params: { user: user_params }
        created_user = User.find_by(email: 'test_1@example.com')
        expect(created_user).not_to be_nil
        expect(created_user.name).to eq('test')
      end.to change(User, :count).by 1
    end

    it 'ユーザーの作成が失敗すること' do
      post user_registration_path, params: { user: invalid_user_params }
      failed_user = User.find_by(email: 'test2@example.com')
      expect(failed_user).to be_nil
    end
  end

  describe 'GET /users/confirmation' do
    it 'トークンが間違っていた時メール認証に失敗すること' do
      user
      get user_confirmation_path(confirmation_token: 'fuga')
      expect(response.body).to include('Confirmation token is invalid')
      created_user = User.find_by(email: 'test_1@example.com')
      expect(created_user.confirmed_at).to be_nil
    end

    it 'トークンが合っている時メール認証に成功すること' do
      get user_confirmation_path(confirmation_token: user.confirmation_token)
      expect(response).to redirect_to new_user_session_path
      created_user = User.find_by(email: 'test_1@example.com')
      expect(created_user.confirmed_at).not_to be_nil
    end
  end

  describe 'DELETE /users/sign_out' do
    it 'ログアウトできること' do
      user.confirm
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
      user.confirm
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
      user.confirm
      sign_in user
      put user_registration_path, params: { user: change_user_params }
      changed_user = User.find_by(email: 'test_1@example.com')
      expect(changed_user.name).to eq('hoge')
      expect(changed_user.biography).to eq('hogehoge')
      expect(changed_user.birthday).to eq(Date.parse('2019-2-10'))
    end
  end

  describe 'DELETE /users' do
    it 'ユーザーの削除ができること' do
      user.confirm
      sign_in user
      delete user_registration_path
      deleted_user = User.find_by(email: 'test_1@example.com')
      expect(deleted_user).to be_nil
    end
  end
end
