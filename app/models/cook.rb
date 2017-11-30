class Cook < ApplicationRecord
 belongs_to :user
 has_many :menus
 has_many :comments
end
