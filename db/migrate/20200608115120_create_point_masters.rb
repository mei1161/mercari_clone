class CreatePointMasters < ActiveRecord::Migration[6.0]
  def change
    create_table :point_masters do |t|
      t.integer :amount
      t.integer :price
      t.date :started_at
      t.date :ended_at
      t.timestamps
    end
  end
end
