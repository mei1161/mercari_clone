# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  biography              :text
#  birthday               :date
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           not null
#  encrypted_password     :string           not null
#  name                   :string           not null
#  point                  :integer          default(0)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    name { 'test' }
    email { 'test_1@example.com' }
    password { 'password' }
  end

  factory :user2, class: User do
    name { 'hoge' }
    email { 'test_2@example.com'}
    password { 'password' }
  end

  factory :invalid_user, class: User do
    name { '' }
    email { 'test2@example.com' }
    password { 'password' }
  end
end
