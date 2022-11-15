class OrderController < ApplicationController
  before_action :authenticate_user!
  def index
    @orders = current_user.orders.includes(:products, :order_products).all.order('created_at DESC')
  end

  def show
    @order = current_user.orders.includes(:products, :order_products).find_by_id(params[:id])
    if @order == nil || !@order.valid?
      flash[:notice] = 'The order is not found.'
      return redirect_to root_path
    end
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
