class AddColumnPoints < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :point, :integer
  end
end
