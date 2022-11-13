class OrderController < ApplicationController
  def index
    @orders = Order.all.order('created_at DESC')
  end

  def show
  end
end
