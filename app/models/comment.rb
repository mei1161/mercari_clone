# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_comments_on_item_id  (item_id)
#  index_comments_on_user_id  (user_id)
#
class Comment < ApplicationRecord
  belongs_to :item
  belongs_to :user
  validates :text, presence: true
end
