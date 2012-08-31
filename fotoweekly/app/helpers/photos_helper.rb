module PhotosHelper

  # accessing model to view
  def photo_tags(photo_id)
    Photo.photo_tags(photo_id)
  end

end

