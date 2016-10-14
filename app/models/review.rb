class Review < ApplicationRecord
  RATINGS = [1, 2, 3, 4, 5]
  belongs_to :user
  belongs_to :product
  has_many :votes, dependent: :destroy
  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :body, presence: true
  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true }
  validates :rating, inclusion: { in: RATINGS, message: "Must be 1 through 5" }
end
