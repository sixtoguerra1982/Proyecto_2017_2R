class CreateCooks < ActiveRecord::Migration[5.1]
  def change
    create_table :cooks do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.string :address_region
      t.string :address_commune
      t.string :address_city
      t.string :picture
      t.text :biography
      t.timestamps
    end
  end
end
