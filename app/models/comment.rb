class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :cook

  validates :content, length: { maximum: 40 }
end
