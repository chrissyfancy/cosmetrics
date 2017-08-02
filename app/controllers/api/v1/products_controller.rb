class Api::V1::ProductsController < ApplicationController
  def index
    products = Product.all
    render json: { products: products }
  end

  def show
    product = Product.find_by(id: params[:id])
    reviews = Review.where(product_id: params[:id])
    average_rating = product.average_rating
    render json: { product: product, rating: average_rating, reviews: reviews}
  end
end
