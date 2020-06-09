class CreatePointHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :point_histories do |t|
      t.references :user
      t.string :type
      t.integer :point
      t.datetime :date
      t.bigint :parent_id
      t.timestamps
    end
  end
end
