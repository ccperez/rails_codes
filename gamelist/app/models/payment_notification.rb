class PaymentNotification < ActiveRecord::Base
  has_one :order, :dependent => :destroy
  serialize :params
  after_create :mark_cart_as_purchased

  def self.save_payment_info(params)
    payment = self.where(:txn_id => params[:txn_id])
    if payment.empty?
      create(
        :params         => params,
        :payment_status => params[:payment_status],
        :txn_id         => params[:txn_id]
      )
    end
  end

  private #-

  def mark_cart_as_purchased
    if payment_status == "Completed" &&
      params[:receiver_email] == APP_CONFIG[:paypal_email] &&
      params[:mc_currency] == APP_CONFIG[:currency] &&
      payment_amount_correct

      save_order
    end
  end

  def payment_amount_correct()
    amount = 0.00
    (1..params[:num_cart_items].to_i).each do |i|
      product = Product.find(params["item_number#{i}"])
      amount += product.price * params["quantity#{i}"].to_i if product
    end
    payment_amount = "%.2f" % (amount+APP_CONFIG[:shipping]).to_s

    payment_amount==params[:mc_gross] ? true : false
  end

  def save_order
    customer = Customer.where(:payer_id => params[:payer_id])
    customer_id = customer[0].id if !customer.empty?
    if customer.empty?
      customer = Customer.new(
        :payer_id        => params[:payer_id],
        :first_name      => params[:first_name],
        :last_name       => params[:last_name],
        :payer_email     => params[:payer_email],
        :address_country => params[:address_country],
        :address_street  => params[:address_street],
        :address_city    => params[:address_city],
        :address_zip     => params[:address_zip],
        :address_state   => params[:address_state]
      )
      customer_id = customer.id if customer.save
    end

    order = Order.where(:payment_notification_id => id)
    if order.empty?
      order = Order.new(
        :payment_notification_id => id,
        :customer_id => customer_id,
        :mc_gross    => params[:mc_gross]
      )

      if order.save
        (1..params[:num_cart_items].to_i).each do |i|
          product = Product.find(params["item_number#{i}"])
          Item.create(
            :order_id   => order.id,
            :product_id => product.id,
            :price      => product.price,
            :quantity   => params["quantity#{i}"]
          )
        end
      end
    end
  end

end

