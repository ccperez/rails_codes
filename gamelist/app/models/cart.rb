class Cart
  attr_reader :items
  attr_reader :total_quantity
  attr_reader :total_price

  def initialize
    empty_all_items
  end

  def empty_all_items
    @items = []
    @total_quantity = 0
    @total_price = 0.0
  end

  def add_product(product)
    existing_item = @items.find {|item| item.product_id == product.id}
    if existing_item
      existing_item.quantity += 1
    else
      @items << Item.new_based_on(product)
    end
    @total_quantity += 1
    @total_price += product.price
  end

  def update_product(carts)
    carts.to_a.reverse.each do |cart|
      quantity = cart[1].to_i
      if quantity > 0
        product = Product.find(cart[0])
        @items << Item.new_based_on(product, quantity)
        @total_quantity += quantity
        @total_price += (quantity * product.price)
      end
    end
  end

  def remove_product(product)
    existing_item = @items.find {|item| item.product_id == product.id}
    if existing_item
      @total_quantity -= existing_item.quantity
      @total_price -= (existing_item.quantity * product.price)
      @items.delete(existing_item)
    end
  end

  def paypal_info()
    values = {
      "paypal_url" => APP_CONFIG[:paypal_url],
      "cmd"        => APP_CONFIG[:cmd],
      "upload"     => APP_CONFIG[:upload],
      "business"   => APP_CONFIG[:paypal_email],
      "shipping"   => APP_CONFIG[:shipping],
      "currency"   => APP_CONFIG[:currency],
      "cert_id"    => APP_CONFIG[:paypal_cert_id],
      "lc"         => APP_CONFIG[:lc],
      "rm"         => APP_CONFIG[:rm],
      "secret"     => APP_CONFIG[:paypal_secret]
    }
  end

  def paypal_encrypted(return_url, notify_url, cancel_url)
    paypal = paypal_info()
    values = {
      :business      => paypal['business'],
      :cmd           => paypal['cmd'],
      :upload        => paypal['upload'],
      :shipping_1    => paypal['shipping'],
      :currency_code => paypal['currency'],
      :lc            => paypal['lc'],
      :rm            => paypal['rm'],
      :cert_id       => paypal['cert_id'],
      :return        => return_url,
      :notify_url    => notify_url,
      :cancel_return => cancel_url
    }
    @items.each_with_index do |item, index|
      values.merge!({
        "item_name_#{index+1}"   => item.product.title,
        "item_number_#{index+1}" => item.product.id,
        "amount_#{index+1}"      => item.product.price,
        "quantity_#{index+1}"    => item.quantity
      })
    end
    encrypt_for_paypal(values)
  end

  PAYPAL_CERT_PEM = File.read("#{Rails.root}/certs/paypal_cert.pem")
  APP_CERT_PEM = File.read("#{Rails.root}/certs/app_cert.pem")
  APP_KEY_PEM = File.read("#{Rails.root}/certs/app_key.pem")

  def encrypt_for_paypal(values)
    signed = OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(APP_CERT_PEM), OpenSSL::PKey::RSA.new(APP_KEY_PEM, ''), values.map { |k, v| "#{k}=#{v}" }.join("\n"), [], OpenSSL::PKCS7::BINARY)
    OpenSSL::PKCS7::encrypt([OpenSSL::X509::Certificate.new(PAYPAL_CERT_PEM)], signed.to_der, OpenSSL::Cipher::Cipher::new("DES3"), OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")
  end

end

