class CheckoutController < ApplicationController
  before_action :authenticate_user!
  def index
    process_tax
  end

  def create
    process_tax

    # create an order
    order_status = OrderStatus.find_by_name('new')
    order = Order.create(
      user_id: current_user.id,
      order_status_id: order_status.id,
      pst: @pst,
      gst: @gst,
      hst: @hst
    )
    if order && order.valid?
      # Create OrderProducts
      @products.each do |product|
        if product.sale != nil
          price = product.price - product.price * product.sale
        else
          price = product.price
        end
        OrderProduct.create(
          order_id: order.id,
          product_id: product.id,
          quantity: params[product.id.to_s].to_i,
          price: price
        )
      end

      # Stripe checkout
      # establish a connection to Stripe, and then redirect the user to the payment screen.
      @session = Stripe::Checkout::Session.create(
        payment_method_types: [:card],
        success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: checkout_cancel_url,
        line_items: [
          {
            name: product.name,
            description: product.description,
            amount: product.price_cents,
            currency: "cad",
            quantity: 1 # hard code, not good to do but for testing only.
          },
          {
            name: 'GST',
            description: "Goods and Services taxes",
            amount: (product.price_cents * 0.05).to_i,
            currency: "cad",
            quantity: 1
          }
        ]
      )

      respond_to do |format|
        format.js #render app/views/checkout/create.js.erb
      end

    else
      flash[:notice] = "Cannot place your order."
      redirect_to root_path
    end
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
      @total_before_taxes += if product.sale != nil
                               (product.price - product.price * product.sale) * params[product.id.to_s].to_i
                             else
                               product.price * params[product.id.to_s].to_i
                             end
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
