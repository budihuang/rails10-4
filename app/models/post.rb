class Post < ApplicationRecord
  belongs_to :user
  belongs_to :grouop
validates :title, presence: true
end
