class Fotoweekly::PhotosTag < Fotoweekly::Db
  belongs_to :photo
  belongs_to :tag

  accepts_nested_attributes_for :tag
end

