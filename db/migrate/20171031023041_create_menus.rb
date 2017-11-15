class CreateMenus < ActiveRecord::Migration[5.1]
  def change
    create_table :menus do |t|
      t.string :name
      t.text :description
      t.string :picture
      t.integer :price
      t.references :cook, foreign_key: true
      t.date :date
      t.timestamps
    end
  end
end
