class Review < ApplicationRecord
  RATINGS = [1, 2, 3, 4, 5]
  DAYS_PER_WEEK = [1, 2, 3, 4, 5, 6, 7]

  belongs_to :user
  belongs_to :product
  has_many :votes, dependent: :destroy

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :body, presence: true
  validates :months_product_lasts, numericality: { only_integer: true }

  validates :times_used_per_week, numericality: { only_integer: true }
  validates :times_used_per_week, inclusion: { in: DAYS_PER_WEEK, message: "Must be 1 through 7" }

  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true }
  validates :rating, inclusion: { in: RATINGS, message: "Must be 1 through 5" }
end
