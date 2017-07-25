class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :review
  validates :score, presence: true
  validates :score, numericality: { only_integer: true }
  validates :score, inclusion: { in: -1..1 }
  validates :user_id, uniqueness: { scope: :review }
  validates :user_id, presence: true
  validates :review_id, presence: true
end
