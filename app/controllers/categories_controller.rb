class CategoriesController < ApplicationController
  before_action :authorize_user, except: [:index, :show]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @products = Product.where(category_id: @category.id)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to root_path, notice: "Successfully added category."
    else
      render :new
    end
  end

  def edit
    @product = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_params)
    if @category.save
      flash[:notice] = "Category was succesfully updated."
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    Category.destroy(params[:id])
    if !@category
      flash[:notice] = "Category succesfully deleted."
      redirect_to root_path
    else
      render :show
    end
  end

  protected
  def category_params
    params.require(:category).permit(:name, :description)
  end

  def authorize_user
    if !current_user.role == "admin"
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end
