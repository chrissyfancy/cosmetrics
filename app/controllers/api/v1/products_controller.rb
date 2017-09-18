class Api::V1::ProductsController < ApplicationController
  def index
    render json: { products: ProductSerializer.products }
  end

  def show
    product = Product.find(params[:id])
    reviews = ProductSerializer.reviews(product)
    average_rating = product.average_rating
    product.average_value = product.product_value(product)
    render json: { product: product, rating: average_rating, reviews: reviews}
  end
end
