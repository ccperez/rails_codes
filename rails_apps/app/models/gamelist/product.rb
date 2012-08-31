class Gamelist::Product < Gamelist::Db
  has_many :items, :dependent => :destroy

end

