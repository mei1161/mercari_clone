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
require 'rails_helper'

RSpec.describe PointHistory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
