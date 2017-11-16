class Menu < ApplicationRecord
  mount_uploader :picture, ImageMenuUploader
  belongs_to :cook

  has_many :orders
  has_many :user, through: :orders
end
