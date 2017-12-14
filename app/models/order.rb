class Order < ApplicationRecord
  belongs_to :user
  belongs_to :menu

  validates :request_description, length: { maximum: 40 }
end
