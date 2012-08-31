class Gamelist::Order < Gamelist::Db
  has_many :items, :dependent => :destroy
  belongs_to :payment_notification
  belongs_to :customer
end

