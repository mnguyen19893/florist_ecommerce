class ProductController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.includes(:category).page params[:page]
  end

  def show
    @product = Product.includes(:category).find(params[:id])
  end

  def filter
    @filter = params[:filter]
    @products = case @filter
                when 'On sale'
                  Product.includes(:category).where.not('sale': nil)
                when 'New'
                  Product.includes(:category).where(created_at: 3.days.ago..Time.now)
                else
                  Product.includes(:category).all
                end
  end

  def search
    category_id = params[:category]
    product_search = "%#{params[:keywords]}%"
    if category_id == ''
      @products = Product.includes(:category).where('name LIKE ?', product_search)
    else
      @products = Product.includes(:category).where('name LIKE ? AND category_id = ?', product_search, category_id)
      @category = Category.find(category_id)
    end
  end
end
