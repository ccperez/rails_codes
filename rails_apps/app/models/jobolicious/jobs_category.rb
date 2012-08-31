class Jobolicious::JobsCategory < Jobolicious::Db
  belongs_to :job
  belongs_to :category
end

