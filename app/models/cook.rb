class Cook < ApplicationRecord
 belongs_to :user
 has_many :menus
 has_many :comments
 mount_uploader :picture, CookUploader
end
