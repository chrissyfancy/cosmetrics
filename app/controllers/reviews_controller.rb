class ReviewsController < ApplicationController

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
