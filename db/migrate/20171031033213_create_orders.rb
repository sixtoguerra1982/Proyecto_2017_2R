class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :menu, foreign_key: true
      t.integer :quantity, default: 0
      t.integer :price
      t.text :request_description
      t.boolean :payed, default: false
      t.datetime :date
      t.timestamps
    end
  end
end
