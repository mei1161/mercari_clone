# == Schema Information
#
# Table name: addresses
#
#  id           :bigint           not null, primary key
#  address1     :string
#  address2     :string
#  name         :string
#  phone_number :string
#  prefecture   :string
#  zipcode      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  item_id      :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_addresses_on_item_id  (item_id)
#  index_addresses_on_user_id  (user_id)
#
class Address < ApplicationRecord
  validates :phone_nuber, presence: true, length: { maximum: 11 }, numericality: { only_integer: true }
  validates :zipcode, presence: true, length: { is: 7 }, numericality: { only_integer: true }
  validates :prefecture, presence: true
  has_many :items
  belongs_to :user
end
