# == Schema Information
#
# Table name: items
#
#  id                   :bigint           not null, primary key
#  include_shipping_fee :boolean
#  item_status          :integer
#  name                 :string
#  price                :integer
#  text                 :text
#  transaction_status   :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  category_id          :bigint
#  user_id              :bigint
#
# Indexes
#
#  index_items_on_category_id  (category_id)
#  index_items_on_user_id      (user_id)
#
require 'rails_helper'

RSpec.describe Item, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
