class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.text :text
      t.string :name
      t.integer :price
      t.integer :item_status
      t.integer :transaction_status
      t.boolean :include_shipping_fee
      t.references :user
      t.references :category
      t.timestamps
    end
  end
end
