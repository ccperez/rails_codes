class CartsController < ApplicationController
  before_filter :find_or_create_cart

  def add
    product = Product.find(params[:id])
    @cart.add_product(product)

    redirect_to(products_path)
  end

  def update
    @cart.update_product(params[:cart])

    redirect_to(:action => 'checkout')
  end

  def remove_from_cart
    product = Product.find(params[:id])
    @cart.remove_product(product)

    redirect_to(:action => 'checkout')
  end

  def checkout
    @paypal = @cart.paypal_info()

    redirect_to(products_path) if @cart.items.empty?
  end

  def thankyou
    PaymentNotification.save_payment_info(params)
  end

end

