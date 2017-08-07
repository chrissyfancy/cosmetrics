class Api::V1::ReviewsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: { product_reviews: ReviewSerializer.product_reviews(params[:product_id]) }
  end

  def create
    review = Review.new(review_params)
    review.product_id = params[:product_id]
    review.user = current_user
    if review.save
      ReviewMailer.new_review(review).deliver_later
      render json: { product_reviews: ReviewSerializer.product_reviews(params[:product_id]) }, status: 200
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
      render json: { review: review }
    else
      render json: { error: "There was an issue saving your review." }, status: :unprocessable_entity
    end
  end

  def destroy
    product = Product.find(params[:product_id])
    Review.destroy(params[:id])
    if !review
      render json: { message: "Review successfully deleted"}
    else
      render json: { error: "There was an error removing your review." }
    end
  end

  private
  def review_params
    params.require(:review).permit(:body, :rating, :product_id, :user_id)
  end
end
