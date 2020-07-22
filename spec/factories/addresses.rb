# == Schema Information
#
# Table name: addresses
#
#  id             :bigint           not null, primary key
#  address1       :string
#  address2       :string
#  name           :string
#  phone_number   :string
#  prefecture_num :integer          default(NULL), not null
#  zipcode        :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  item_id        :bigint
#  user_id        :bigint
#
# Indexes
#
#  index_addresses_on_item_id  (item_id)
#  index_addresses_on_user_id  (user_id)
#
FactoryBot.define do
  factory :address do
    address1 { 'address1' }
    address2 { 'address2' }
    name { '太郎' }
    phone_number {'01234567890'}
    zipcode { '1234567' }
    prefecture_num { '北海道' }
  end
end
