class Gamelist::MainController < ApplicationController

  protected #-

  def find_or_create_cart
    @cart = session[:cart] ||= Gamelist::Cart.new
  end

end

