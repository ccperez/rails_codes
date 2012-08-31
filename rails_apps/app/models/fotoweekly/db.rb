class Fotoweekly::Db < ActiveRecord::Base
  establish_connection :fotoweekly
  self.abstract_class = true
end

