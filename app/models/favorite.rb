class Favorite < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :user_id, uniqueness: {scope: :book_id}
end
