class ChangeColumnType < ActiveRecord::Migration[6.0]
  def change
    remove_column :evalutions, :type, :integer
    add_column :evalutions, :status, :integer
  end
end
