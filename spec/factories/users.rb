FactoryBot.define do
  factory :user do
    name { 'test' }
    email { 'test_1@example.com' }
    password { 'password' }
  end

  factory :invalid_user, class: User do
    name { ' ' }
    email { 'test2@example.com' }
    password { 'password' }
  end
end
