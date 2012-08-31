class Jobolicious::Db < ActiveRecord::Base
  establish_connection :jobolicious
  self.abstract_class = true
end

