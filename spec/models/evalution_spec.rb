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
require 'rails_helper'

RSpec.describe Evalution, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
