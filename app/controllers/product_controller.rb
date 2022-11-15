class ProductController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.includes(:category).page params[:page]
  end

  def show
    @product = Product.includes(:category).find_by_id(params[:id])
    if @product == nil || !@product.valid?
      flash[:notice] = 'The product is not found.'
      redirect_to root_path
    end
  end

  def filter
    @filter = params[:filter]
    @products = case @filter
                when 'On sale'
                  Product.includes(:category).where.not('sale': nil).page params[:page]
                when 'New'
                  Product.includes(:category).where(created_at: 3.days.ago..Time.now).page params[:page]
                else
                  Product.includes(:category).all.page params[:page]
                end
  end

  def search
    category_id = params[:category]
    product_search = "%#{params[:keywords]}%"
    if category_id == ''
      @products = Product.includes(:category).where('name LIKE ?', product_search).page params[:page]
    else
      @products = Product.includes(:category).where('name LIKE ? AND category_id = ?', product_search, category_id).page params[:page]
      @category = Category.find(category_id)
    end
  end
end
