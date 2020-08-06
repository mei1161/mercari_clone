# == Schema Information
#
# Table name: evalutions
#
#  id         :bigint           not null, primary key
#  text       :text
#  type       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_evalutions_on_item_id  (item_id)
#  index_evalutions_on_user_id  (user_id)
#
class Evalution < ApplicationRecord
  validates :type, presence: true
  validates :text, length: { maximum: 500 }
  belongs_to :user
  belongs_to :item
  ## define enum
  enum type: { good: 0, normal: 1, bad: 2 }
end
