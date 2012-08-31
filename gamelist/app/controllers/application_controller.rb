class ApplicationController < ActionController::Base
  protect_from_forgery

  protected #-

  def find_or_create_cart
    @cart = session[:cart] ||= Cart.new
  end

end

