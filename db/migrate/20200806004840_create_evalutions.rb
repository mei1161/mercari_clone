class CreateEvalutions < ActiveRecord::Migration[6.0]
  def change
    create_table :evalutions do |t|
      t.integer :type
      t.text :text
      t.references :user
      t.references :item
      t.timestamps
    end
  end
end
