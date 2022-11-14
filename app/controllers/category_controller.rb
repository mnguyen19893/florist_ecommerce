class CategoryController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def show
    @category = Category.includes(:products).find(params[:id])
  end
end
