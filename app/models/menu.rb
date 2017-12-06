class Menu < ApplicationRecord
  mount_uploader :picture, ImageMenuUploader
  belongs_to :cook
  has_many :orders
  has_many :user, through: :orders
  has_many :users, through: :cooks

  def editable
    if self.date != Date.today
      false
    else
      true
    end
  end
 # Menu editable True cuando el menu se puede ingresar stock ya que la fecha de venta es igual a la
 # actual.

 # Menu editable

end
