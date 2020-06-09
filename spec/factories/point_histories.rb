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
FactoryBot.define do
  factory :point_history do
    
  end
end
