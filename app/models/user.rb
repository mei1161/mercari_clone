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
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true
  validates :email, presence: true
  validates :biography, length: { maximum: 150 }
  has_many :items
  has_many :likes
  has_many :liked_items, through: :likes, source: :item
  has_many :comments
  has_many :addresses
  def point_purchase(point_master)
    self.point += point_master.amount
    save
    PointPurchaseHistory.create(user: self, date: DateTime.now, parent_id: point_master.id, point: point_master.amount)
  end

  def point_sub(item)
    self.point -= item.price
    save
    PointBuyHistory.create(user: self, date: DateTime.now, parent_id: item.id, point: -item.price)
  end

  def point_add(item)
    item.user.point += item.price
    save
    PointSellHistory.create(user: item.user, date: DateTime.now, parent_id: item.id, point: item.price)
  end
end
