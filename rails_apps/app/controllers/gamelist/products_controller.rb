class Gamelist::ProductsController < Gamelist::MainController
  before_filter :find_or_create_cart, :only => [:index]

  layout('gamelist')

  def index
    @products = Gamelist::Product.order("gamelist_products.id DESC")
  end

  def show
    @product = Gamelist::Product.find(params[:id])
  end

end

