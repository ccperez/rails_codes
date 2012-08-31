class Jobolicious::Category < Jobolicious::Db
  has_many :jobs_categories, :dependent => :destroy
  has_many :jobs, :through => :jobs_categories
end

