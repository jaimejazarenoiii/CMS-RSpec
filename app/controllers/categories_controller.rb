class CategoriesController < ApplicationController
  before_action :ensure_admin, only: %i[new create]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to products_path, notice: "Successful"
    else
      render "new"
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def ensure_admin
    redirect_to products_path, alert: "Invalid User" unless current_user.admin?
  end
end
