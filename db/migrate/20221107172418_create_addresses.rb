class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :number
      t.string :street
      t.string :city
      t.string :postal_code
      t.integer :user_id
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end
# 20221107172349
# 20221107172418
