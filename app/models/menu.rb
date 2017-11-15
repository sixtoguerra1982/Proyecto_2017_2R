class Menu < ApplicationRecord
  mount_uploader :picture, ImageMenuUploader
  belongs_to :cook
end
