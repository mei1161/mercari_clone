# == Schema Information
#
# Table name: items
#
#  id                   :bigint           not null, primary key
#  include_shipping_fee :boolean
#  item_status          :integer
#  name                 :string
#  price                :integer
#  text                 :text
#  transaction_status   :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  category_id          :bigint
#  user_id              :bigint
#
# Indexes
#
#  index_items_on_category_id  (category_id)
#  index_items_on_user_id      (user_id)
#
class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :price, presence: true, numericality: { greater_than: 5 }
  validates :name, presence: true
  validates :transaction_status, presence: true
  validates :item_status, presence: true
  validates :text, length: { maximum: 1000 }
  validates :include_shipping_fee, presence: true, default: false
  ## define enum
  enum transaction_status: { draft: 0, sale: 1, shipping: 2, wait_sender_review: 3, wait_recever_review: 4, sold_out: 5, hidden: 6 }
  enum item_status: { new: 0, like_new: 1, good: 2, fair: 3, poor: 4 }, _prefix: true
end
