class OrderController < ApplicationController
  before_action :authenticate_user!
  def index
    @orders = Order.includes(:products, :order_products).all.order('created_at DESC')
  end

  def show
    @order = Order.includes(:products, :order_products).find(params[:id])
    @products = @order.products

    @total_before_taxes = 0
    @products.each do |product|
      price = product.order_products.where("order_id = #{@order.id}").first.price
      quantity = product.order_products.where("order_id = #{@order.id}").first.quantity
      @total_before_taxes += price * quantity
    end
    @pst = @order.pst
    @gst = @order.gst
    @hst = @order.hst
    @pst_price = @total_before_taxes * @pst
    @gst_price = @total_before_taxes * @gst
    @hst_price = @total_before_taxes * @hst
    @total = @total_before_taxes + @pst_price + @gst_price + @hst_price
  end
end
