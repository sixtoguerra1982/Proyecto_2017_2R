class Comment < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :cook

  validates :content, length: { maximum: 40 }
end
