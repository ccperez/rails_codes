class Gamelist::PaymentNotificationsController < Gamelist::MainController
  protect_from_forgery :except => [:create]

  def create
    Gamelist::PaymentNotification.save_payment_info(params)
    render :nothing => true
  end

end

