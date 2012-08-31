class Gamelist::CartsController < Gamelist::MainController
  before_filter :find_or_create_cart

  layout('gamelist')

  def show
    if @cart.items.empty?
      redirect_to(gamelist_products_path)
    else
      checkout
      render('checkout')
    end
  end

  def add
    product = Gamelist::Product.find(params[:id])
    @cart.add_product(product)

    redirect_to(gamelist_products_path)
  end

  def update
    @cart.update_product(params[:cart])

    redirect_to(:action => 'checkout')
  end

  def remove_from_cart
    product = Gamelist::Product.find(params[:id])
    @cart.remove_product(product)

    redirect_to(:action => 'checkout')
  end

  def checkout
    @paypal = @cart.paypal_info()
  end

  def thankyou
    Gamelist::PaymentNotification.save_payment_info(params)
  end

end

