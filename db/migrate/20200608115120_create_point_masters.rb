class CreatePointMasters < ActiveRecord::Migration[6.0]
  def change
    create_table :point_masters do |t|
      t.integer :amount
      t.integer :price
      t.datetime :started_at
      t.datetime :ended_at
      t.timestamps
    end
  end
end
