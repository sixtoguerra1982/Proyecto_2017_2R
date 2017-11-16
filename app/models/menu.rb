class Menu < ApplicationRecord
  mount_uploader :picture, ImageMenuUploader
  belongs_to :cook
  has_many :orders
  has_many :user, through: :orders
  has_many :users, through: :cooks
end
