class CartController < ApplicationController
  def index
    @products = Product.find(session[:shopping_cart])
  end

  def create
    product_id = params[:id].to_i
    unless session[:shopping_cart].include?(product_id)
      product = Product.find(product_id)
      session[:shopping_cart] << product_id
      flash[:notice] = "#{product.name} added to cart."
    end
    redirect_to root_path
  end

  def destroy
    product_id = params[:id].to_i
    session[:shopping_cart].delete(product_id)
    product = Product.find(product_id)
    flash[:notice] = "#{product.name} removed from cart"
    redirect_to root_path
  end
end
