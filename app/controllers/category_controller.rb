class CategoryController < ApplicationController
  def index
  end

  def show
    @category = Category.includes(:products).find(params[:id])
  end
end
