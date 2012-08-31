class Gamelist::Customer < Gamelist::Db
  has_many :orders, :dependent => :destroy

end

