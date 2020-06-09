# == Schema Information
#
# Table name: point_masters
#
#  id         :bigint           not null, primary key
#  amount     :integer
#  ended_at   :datetime
#  price      :integer
#  started_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PointMaster < ApplicationRecord
  validates :amount, presence: true
  validates :price, presence: true
  validates :started_at, presence: true
  validates :ended_at, presence: true
end
