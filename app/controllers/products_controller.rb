class ProductsController < ApplicationController
  before_action :ensure_valid_user, only:  %i[edit update destroy]
  before_action :ensure_user_is_signed_in, only: %i[new create]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    @categories = Category.all
    if @product.save
      redirect_to product_path(@product.id), notice: "Successful"
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @product.update_attributes(product_params)
      redirect_to product_path(@product.id), notice: "Successful"
    else
      render "edit"
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    permit_params = :name, :description, :price, :category_id, :image
    c_user = current_user
    params.require(:product).permit(permit_params).merge(user_id: c_user.id)
  end

  def ensure_valid_user
    @product = Product.find(params[:id])
    @categories = Category.all
    unless @product.user == current_user || current_user.admin?
      redirect_to product_path(@product.id), alert: "Invalid User"
    end
  end

  def ensure_user_is_signed_in
    error_message = "You need to be signed in to perform this action."
    redirect_to products_path, alert: error_message unless user_signed_in?
  end
end
