class AddStockToMenus < ActiveRecord::Migration[5.1]
  def change
  	add_column :menus, :stock, :integer, default: 0
  end
end
