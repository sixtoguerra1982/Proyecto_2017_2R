class AddcookToUsers < ActiveRecord::Migration[5.1]

  def change
  	add_reference :cooks, :user, index: true
  	add_foreign_key :cooks, :users
  end

  
  ##En progres se agregara la integridad de la tabla Cooks, para que solo pertenesca
  ##a un usuario##  
end
