class Api::V1::ReviewsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    reviews = Review.where(product_id: params[:product_id])
    render json: { reviews: reviews }
  end

  def create
    review = Review.new(review_params)
    review.product_id = params[:product_id]
    review.user = current_user
    if review.save
      ReviewMailer.new_review(review).deliver_later
      product = Product.find(params[:product_id])
      reviews = ProductSerializer.reviews(product)
      average_rating = product.average_rating
      render json: { product: product, rating: average_rating, reviews: reviews}
    else
      render json: { error: "There was an issue saving your review." }, status: :unprocessable_entity
    end
  end

  def show
    product = Product.find_by(id: params[:id])
    reviews = Review.where(product_id: params[:id])
    average_rating = product.average_rating
    render json: { product: product, rating: average_rating, reviews: reviews}
  end

  private
  def review_params
    params.require(:review).permit(:body, :rating, :product_id, :user_id)
  end
end
