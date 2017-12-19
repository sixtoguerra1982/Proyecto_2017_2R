class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  mount_uploader :picture, AvatarUploader

  has_many :cooks
  has_many :orders, dependent: :destroy
  has_many :header_orders, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :menus, through: :cooks


  enum role: [:visit, :admin, :cook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end

end
