class ChangeColumnPrefecture < ActiveRecord::Migration[6.0]

  def up
    add_column :addresses, :prefecture_num, :integer, default: 0, null: false
  end
end
