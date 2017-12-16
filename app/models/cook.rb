class Cook < ApplicationRecord

  belongs_to :user
  has_many :menus, dependent: :destroy
  has_many :comments, dependent: :destroy



  mount_uploader :picture, CookUploader



  validates :name, length: { maximum: 35 }
  validates :email, length: { maximum: 40 }
  validates :phone, length: { maximum: 17 }
  validates :address, length: { maximum: 60 }
  validates :address_region, length: { maximum: 40 }
  validates :address_commune, length: { maximum: 40 }
  validates :address_city, length: { maximum: 40 }
  validates :biography, length: { maximum: 350 }
end
