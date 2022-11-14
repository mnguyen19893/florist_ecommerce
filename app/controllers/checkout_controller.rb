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

      product_name = order.order_products.map { |op| op.product.name.to_s }.join(', ').html_safe
      description = "A purchase from Florist Ecommerce"

      # Stripe checkout
      # establish a connection to Stripe, and then redirect the user to the payment screen.
      @session = Stripe::Checkout::Session.create(
        payment_method_types: [:card],
        success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: checkout_cancel_url,
        line_items: [
          {
            name: "#{order.id}",
            description: description,
            amount: (@total_before_taxes * 100).to_i,
            currency: "cad",
            quantity: 1
          },
          {
            name: 'Taxes',
            description: "Goods and Services taxes",
            amount: (@total_before_taxes * (@pst_price + @gst_price + @hst_price)).to_i,
            currency: "cad",
            quantity: 1
          }
        ]
      )
      # https://stackoverflow.com/questions/70733756/redirect-to-external-stripe-checkout-url-not-working-in-rails-7
      redirect_to @session.url, status: 303, allow_other_host: true

    else
      flash[:notice] = "Cannot place your order."
      redirect_to root_path
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

    if @session[:payment_status] == 'paid'
      payment_id = @session[:payment_intent]
      order_id = @session[:display_items][0][:custom][:name]
      order_status_paid = OrderStatus.find_by_name('paid')

      # update payment_id, order_status to paid
      order = Order.find(order_id)
      order.payment_id = payment_id
      order.order_status_id = order_status_paid.id
      order.save

      # empty array of product IDs 
      session[:shopping_cart] = []

      flash[:notice] = 'Your order is successfully processed.'
    else
      flash[:notice] = 'Cannot process your order.'
    end
    redirect_to root_path
  end

  def cancel
    flash[:notice] = 'You cancel the transaction.'
    redirect_to root_path
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
