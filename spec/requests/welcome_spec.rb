require 'rails_helper'

describe 'root_path' do
  it 'Helloworldが表示されること' do
    get root_path
    expect(response).to have_http_status(:ok)
    end
  end