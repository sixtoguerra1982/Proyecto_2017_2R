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

  validates :name, length: { maximum: 30 }
  validates :description, length: { maximum: 30 }
  validates :price, length: { maximum: 5 }
end
