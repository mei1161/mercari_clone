class AddColumnToItems < ActiveRecord::Migration[6.0]
  def up
    add_column :items, :buyer_address_id, :bigint
    remove_column :addresses, :prefecture, :string
  end
end
