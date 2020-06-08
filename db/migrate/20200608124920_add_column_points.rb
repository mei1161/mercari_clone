class AddColumnPoints < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :points, :integer
  end
end
