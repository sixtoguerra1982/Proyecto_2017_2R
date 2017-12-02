class Menu < ApplicationRecord
  mount_uploader :picture, ImageMenuUploader
  belongs_to :cook
  has_many :orders
  has_many :user, through: :orders
  has_many :users, through: :cooks

  def editable
    if self.date.strftime("%Y%m%d") != Time.now.strftime("%Y%m%d")
      false
    else
      true
    end
  end


end
