class Api::V1::ReviewsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: { reviews: Review.where(product_id: params[:product_id]) }
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
      product.average_value = product.product_value(product).to_f
      product.save!
      render json: { product: product, rating: average_rating, reviews: reviews}
    else
      render json: { error: "There was an issue saving your review." }, status: :unprocessable_entity
    end
  end

  def show
    render json: { review: Review.find(params[:id]) }
  end

  def update
    review = Review.find(params[:id])
    review.product_id = params[:product_id]
    review.user = current_user
    review.update(review_params)
    if review.save
      product = Product.find(params[:product_id])
      reviews = ProductSerializer.reviews(product)
      average_rating = product.average_rating
      product.average_value = product.product_value(product)
      render json: { product: product, rating: average_rating, reviews: reviews}
    else
      render json: { error: "There was an issue saving your review." }, status: :unprocessable_entity
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    product = Product.find(params[:product_id])
    reviews = ProductSerializer.reviews(product)
    average_rating = product.average_rating
    product.average_value = product.product_value(product)
    render json: { product: product, rating: average_rating, reviews: reviews}
  end

  private
  def review_params
    params.require(:review).permit(:body, :rating, :product_id, :months_product_lasts, :times_used_per_week, :user_id)
  end
end
