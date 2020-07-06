# == Schema Information
#
# Table name: addresses
#
#  id           :bigint           not null, primary key
#  address1     :string
#  address2     :string
#  name         :string
#  phone_number :string
#  prefecture   :string
#  zipcode      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  item_id      :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_addresses_on_item_id  (item_id)
#  index_addresses_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Address, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
