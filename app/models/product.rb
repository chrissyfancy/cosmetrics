class Product < ApplicationRecord
  belongs_to :category
  has_many :reviews
  has_many :users, through: :reviews

  max_paginates_per 5

  validates :name, presence: true
  validates :brand, presence: true


  def average_rating
    sum = 0.0
    if reviews.length > 0
      reviews.each do |review|
        sum += review.rating.to_f
      end
      sum = sum / reviews.length
      sum = sum.round(1)
    else
      sum = 0.0
    end
  end

  def self.search(search)
    where("name ILIKE ? OR brand ILIKE ?", "%#{search}%", "%#{search}%")
  end
end
