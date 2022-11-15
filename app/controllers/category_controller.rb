class CategoryController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def show
    @category = Category.includes(:products).find_by_id(params[:id])
    if @category == nil || !@category.valid?
      flash[:notice] = 'The category is not found.'
      redirect_to root_path
    end
  end
end
