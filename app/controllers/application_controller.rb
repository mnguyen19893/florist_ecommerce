class ApplicationController < ActionController::Base
  before_action :initialize_session
  helper_method :cart

  def initialize_session
    puts "Hoang initialize_session"
    if user_signed_in?
      session[:shopping_cart] ||= [] # empty array of product IDs
    end
  end

  def cart
    if user_signed_in?
      Product.find(session[:shopping_cart])
    end
  end
end
