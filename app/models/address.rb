# == Schema Information
#
# Table name: addresses
#
#  id             :bigint           not null, primary key
#  address1       :string
#  address2       :string
#  name           :string
#  phone_number   :string
#  prefecture     :string
#  prefecture_num :integer          default(0), not null
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
class Address < ApplicationRecord
  validates :phone_number, presence: true, length: { maximum: 11 }, numericality: { only_integer: true }
  validates :zipcode, presence: true, length: { is: 7 }, numericality: { only_integer: true }
  validates :prefecture_num, presence: true
  has_many :items
  belongs_to :user

  enum prefecture_num: {
    "---": 0,
    北海道: 1, 青森県: 2, 岩手県: 3, 宮城県: 4, 秋田県: 5, 山形県: 6, 福島県: 7,
    茨城県: 8, 栃木県: 9, 群馬県: 10, 埼玉県: 11, 千葉県: 12, 東京都: 13, 神奈川県: 14,
    新潟県: 15, 富山県: 16, 石川県: 17, 福井県: 18, 山梨県: 19, 長野県: 20,
    岐阜県: 21, 静岡県: 22, 愛知県: 23, 三重県: 24,
    滋賀県: 25, 京都府: 26, 大阪府: 27, 兵庫県: 28, 奈良県: 29, 和歌山県: 30,
    鳥取県: 31, 島根県: 32, 岡山県: 33, 広島県: 34, 山口県: 35,
    徳島県: 36, 香川県: 37, 愛媛県: 38, 高知県: 39,
    福岡県: 40, 佐賀県: 41, 長崎県: 42, 熊本県: 43, 大分県: 44, 宮崎県: 45, 鹿児島県: 46,
    沖縄県: 47
  }

  def address_info
    zipcode + prefecture_num.to_s + address1 + address2 + name
  end
end
