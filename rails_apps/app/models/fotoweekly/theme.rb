class Fotoweekly::Theme < Fotoweekly::Db
  has_many :photos

  scope :sorted, order('fotoweekly_themes.id DESC')

end

