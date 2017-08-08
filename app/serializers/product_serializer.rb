class ProductSerializer < ActiveModel::Serializer
  attributes :id, :products

  def self.products
    Product.all
  end

  def self.reviews(product)
    user_reviews = []
    reviews = Review.where(product_id: product).order(created_at: "DESC")

    if reviews
      reviews.each do |review|
        user_reviews << { "review": review, "user": User.find(review.user_id) }
      end
    end
    return user_reviews
  end
end
