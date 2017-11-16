class Menu < ApplicationRecord
  mount_uploader :picture, ImageMenuUploader
  belongs_to :cook
  has_many :users, through: :cooks
end
