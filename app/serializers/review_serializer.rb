class ReviewSerializer < ActiveModel::Serializer
  attributes :id

  def self.product_reviews(product)
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
