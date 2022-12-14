class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      #t.integer :user_id
      #t.integer :order_status_id
      t.string :payment_id
      t.decimal :pst
      t.decimal :gst
      t.decimal :hst
      t.references :order_status, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
