class AddColumnEvalutedUserToEvalution < ActiveRecord::Migration[6.0]
  def change
    add_column :evalutions, :evaluted_user_id, :bigint
  end
end
