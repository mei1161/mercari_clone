# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_likes_on_item_id  (item_id)
#  index_likes_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Like, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
