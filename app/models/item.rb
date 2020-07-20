# == Schema Information
#
# Table name: items
#
#  id                   :bigint           not null, primary key
#  images               :json
#  include_shipping_fee :boolean
#  item_status          :integer
#  name                 :string
#  price                :integer
#  text                 :text
#  transaction_status   :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  buyer_address_id     :bigint
#  buyer_id             :bigint
#  category_id          :bigint
#  user_id              :bigint
#
# Indexes
#
#  index_items_on_category_id  (category_id)
#  index_items_on_user_id      (user_id)
#
class Item < ApplicationRecord
  mount_uploaders :images, ImageUploader
  serialize :images
  ## validation
  belongs_to :user
  belongs_to :buyer, optional: true, class_name: 'User'
  belongs_to :category
  belongs_to :buyer_address, foreign_key: 'buyer_address_id', optional: true, class_name: 'Address'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :price, presence: true, numericality: { greater_than: 5 }
  validates :name, presence: true
  validates :transaction_status, presence: true
  validates :item_status, presence: true
  validates :text, length: { maximum: 1000 }
  validates :include_shipping_fee, default: false
  ## define enum
  enum transaction_status: { draft: 0, sale: 1, shipping: 2, wait_sender_review: 3, wait_recever_review: 4, sold_out: 5, hidden: 6 }
  enum item_status: { new: 0, like_new: 1, good: 2, fair: 3, poor: 4 }, _prefix: true
  ## scope
  scope :sales, -> { where(transaction_status: :sale) }
  scope :drafts, -> { where(transaction_status: :draft) }
  scope :not_drafts, -> { where.not(transaction_status: :draft) }
  scope :sold_outs, -> { where.not(transaction_status: :sale).where.not(transaction_status: :draft) }
  scope :displays, -> { where.not(transaction_status: :draft).where.not(transaction_status: :hidden) }

  def point_buy(purchaser)
    self.buyer = purchaser
    self.transaction_status = :shipping
    save
    pp buyer.point
    buyer.point -= price
    user.point += price
    user.save
    PointBuyHistory.create(user: buyer, date: DateTime.now, parent_id: id, point: -price)
    PointSellHistory.create(user: user, date: DateTime.now, parent_id: id, point: price)
    save
  end
end
