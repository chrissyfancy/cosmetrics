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

  private
  def review_params
    params.require(:review).permit(:body, :rating)
  end
end
