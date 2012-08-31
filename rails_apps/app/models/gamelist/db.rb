class Gamelist::Db < ActiveRecord::Base
  establish_connection :gamelist
  self.abstract_class = true
end

