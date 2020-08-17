# == Schema Information
#
# Table name: evalutions
#
#  id               :bigint           not null, primary key
#  status           :integer
#  text             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  evaluted_user_id :bigint
#  item_id          :bigint
#  user_id          :bigint
#
# Indexes
#
#  index_evalutions_on_item_id  (item_id)
#  index_evalutions_on_user_id  (user_id)
#
class Evalution < ApplicationRecord
  validates :status, presence: true
  validates :text, length: { maximum: 500 }
  belongs_to :user
  belongs_to :item
  belongs_to :evaluted_user, class_name: 'User'
  ## define enum
  enum status: { good: 0, normal: 1, bad: 2 }
end
