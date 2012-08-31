module Fotoweekly::PhotosHelper

  # accessing model to view
  def photo_tags(photo_id)
    Fotoweekly::Photo.photo_tags(photo_id)
  end

end

