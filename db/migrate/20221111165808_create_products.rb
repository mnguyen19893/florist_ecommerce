class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description_url
      t.string :containers
      t.string :flower_time
      t.decimal :sale
      t.decimal :price
      #t.integer :category_id
      t.references :category, null: false, foreign_key: true
      t.timestamps
    end
  end
end
