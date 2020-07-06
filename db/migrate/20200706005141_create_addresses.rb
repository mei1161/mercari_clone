class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :zipcode
      t.string :prefecture
      t.string :address1
      t.string :address2
      t.string :phone_number
      t.string :name
      t.references :user
      t.references :item
      t.timestamps
    end
  end
end
