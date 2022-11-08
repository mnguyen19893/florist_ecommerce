class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :number
      t.string :street
      t.string :city
      t.integer :province_id
      t.string :postal_code
      t.integer :user_id

      t.timestamps
    end
  end
end
