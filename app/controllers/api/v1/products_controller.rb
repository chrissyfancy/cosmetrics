class Api::V1::ProductsController < ApplicationController
  def index
    render json: { products: Product.all }
  end

  def show
    product = Product.find(params[:id])
    render json: { product: product, rating: product.average_rating }
  end
end
