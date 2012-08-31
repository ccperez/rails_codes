class Item < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  def self.new_based_on(product, quantity=nil)
    item = self.new
    item.product = product
    item.quantity = quantity ||= 1
    item.price = product.price
    return item
  end

end

