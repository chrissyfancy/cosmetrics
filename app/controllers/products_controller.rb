class ProductsController < ApplicationController
  before_action :authorize_user, except: [:index, :show]

  def index
    if params[:search]
      @products = Product.search(params[:search]).page(params[:page]).per(5)
    else
      @products = Product.page(params[:page]).per(5)
    end
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])
    @review = Review.new
    @reviews = @product.reviews
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: "Successfully added product."
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    if @product.save
      flash[:notice] = "Product was succesfully updated."
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    Product.destroy(params[:id])
    if !@product
      flash[:notice] = "Product succesfully deleted."
      redirect_to products_path
    else
      render :show
    end
  end

  protected
  def product_params
    params.require(:product).permit(:name, :brand, :description, :price, :color, :product_photo, :category_id, :size)
  end

  def authorize_user
    if !current_user.role == "admin"
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end
