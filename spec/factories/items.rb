# == Schema Information
#
# Table name: items
#
#  id                   :bigint           not null, primary key
#  images               :json
#  include_shipping_fee :boolean
#  item_status          :integer
#  name                 :string
#  price                :integer
#  text                 :text
#  transaction_status   :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  buyer_id             :bigint
#  category_id          :bigint
#  user_id              :bigint
#
# Indexes
#
#  index_items_on_category_id  (category_id)
#  index_items_on_user_id      (user_id)
#
FactoryBot.define do
  factory :item do
    price { 1200 }
    name { 'hoge' }
    transaction_status { 'sale' }
    item_status { 'new' }
    text { 'hogehoge' }
    include_shipping_fee { true }
    images { [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/images/test.jpg'))] }
  end

  factory :invalid_item_params, class: Item do
    price { 0 }
    name { 'hogehogehoge' }
    transaction_status { 'draft' }
    item_status { 'new' }
    text { 'hogehoge' }
    include_shipping_fee { true }
    images { [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/images/test.jpg'))] }
  end
end
