class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :picture, AvatarUploader

  has_many :cooks
  has_many :orders
  has_many :menus, through: :orders
  has_many :menus, through: :cooks

  enum role: [:visit, :admin, :cook]


end
