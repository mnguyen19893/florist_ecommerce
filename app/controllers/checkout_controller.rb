class CheckoutController < ApplicationController
  def index
    process_tax
  end

  def create
    process_tax

    # create an order
    order_status = OrderStatus.where(name: 'new')
    order = order_status.orders.create(
      customer_id: current_user.id,
      pst: @pst,
      gst: @gst,
      hst: @hst
    )

    # Create OrderProducts
    @products.each do |product|
      OrderProduct.create(
        order_id: order.id,
        product_id: product.id,
        quantity: params[product.id.to_s].to_i,
        price: product.price
      )
    end

    flash[:notice] = "Your order is placed successfully."
    redirect_to root_path

  end

  def success

  end

  def cancel

  end

  private
  def process_tax
    # get all products in cart
    @products = Product.find(session[:shopping_cart])

    @total_before_taxes = 0
    @product_quantity = {
    }
    @products.each do |product|
      @product_quantity[product.id] = params[product.id.to_s].to_i
      @total_before_taxes += product.price * params[product.id.to_s].to_i
    end
    @pst = current_user.address.province.pst
    @gst = current_user.address.province.gst
    @hst = current_user.address.province.hst
    @pst_price = @total_before_taxes * @pst
    @gst_price = @total_before_taxes * @gst
    @hst_price = @total_before_taxes * @hst
    @total = @total_before_taxes + @pst_price + @gst_price + @hst_price
  end
end
