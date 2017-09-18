class Product < ApplicationRecord
  belongs_to :category
  has_many :reviews
  has_many :users, through: :reviews

  max_paginates_per 10

  validates :average_value, presence: true
  validates :average_value, numericality: { only_integer: true }
  validates :name, presence: true
  validates :brand, presence: true

  def average_rating
    sum = 0.0
    if reviews.length > 0
      reviews.each do |review|
        sum += review.rating.to_f
      end
      return (sum/reviews.length).round(1)
    end
  end

  def product_value(product)
    sum = 0.0
    if !product.reviews.empty?
      product.reviews.each do |review|
        sum += product_lifespan(review) / price_per_unit(product)
      end
      average_product_value = (sum / product.reviews.length).to_f
      return average_product_value * average_rating
    end
  end

  def product_lifespan(review)
    usage_per_month = (review.times_used_per_week / 7.to_f) * 30.42
    months_product_lasts = review.months_product_lasts.to_f
    return usage_per_month * months_product_lasts
  end

  def price_per_unit(product)
    (product.price / product.size).to_f
  end

  def self.search(search)
    where("name ILIKE ? OR brand ILIKE ?", "%#{search}%", "%#{search}%")
  end
end
