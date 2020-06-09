# == Schema Information
#
# Table name: point_histories
#
#  id         :bigint           not null, primary key
#  date       :datetime
#  point      :integer
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_point_histories_on_user_id  (user_id)
#
class PointPurchaseHistory < PointHistory
  belongs_to :user
  validates :point, presence: true
  validates :date, presence: true
  validates :parent_id, presence: true
  belongs_to :point_master, foreign_key: 'parent_id'
end
