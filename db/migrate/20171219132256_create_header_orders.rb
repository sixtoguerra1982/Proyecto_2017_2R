class CreateHeaderOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :header_orders do |t|
      t.references :user, foreign_key: true
      t.string :payment_address, default: ""
      t.integer :total, default: 0
      t.date :date
      t.integer :way_to_pay, default: 0
      t.string :indication, default: ""
      t.integer :delivery , default: 0
      t.string :place_delivery, default: ""
      t.boolean :payed, default: false
      t.timestamps
    end
  end
end
