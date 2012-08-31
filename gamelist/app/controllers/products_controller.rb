class ProductsController < ApplicationController
  before_filter :find_or_create_cart, :only => [:index]

  def index
    @products = Product.order("products.id DESC")
  end

  def show
    @product = Product.find(params[:id])
  end

end

