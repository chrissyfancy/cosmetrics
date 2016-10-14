class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @product = Product.find(params[:id])
  end

  def create
    @user = current_user
    @product = Product.find(params[:product_id])
    @review = Review.new(review_params)
    @review.product_id = params[:product_id]
    @review.user = current_user
    if @review.save
      ReviewMailer.new_review(@review).deliver_later
      redirect_to @product, notice: "Thank you. Your review has been saved."
    else
      flash[:error] = "There was an issue saving with your review."
      render "products/show"
    end
  end

  def edit
    @review = Review.find(params[:id])
    @product = Product.find(params[:product_id])
  end

  def update
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    @review.update(review_params)
    if @review.save
      flash[:notice] = "Review was successfully updated."
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    Review.destroy(params[:id])
    if !@review
      flash[:notice] = "Review succesfully deleted."
      redirect_to product_path(@product)
    else
      render "products/show"
    end
  end

  def upvote
    @review = Review.find(params[:review_id])
    @review.votes.create
    vote = Vote.find_by(user: current_user, review: @review)
    if vote
      vote.score += 1
      vote.save
    else
      Vote.create!(user: current_user, review: @review, score: 1)
    end
  end

  def downvote
    @review = Review.find(params[:review_id])
    @review.votes.create
    vote = Vote.find_by(user: current_user, review: @review)
    if vote
      vote.score -= 1
      vote.save
    else
      Vote.create!(user: current_user, review: @review, score: -1)
    end
  end

  private
  def review_params
    params.require(:review).permit(:body, :rating)
  end
end
