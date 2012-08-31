module ThemesHelper

  # accessing model to view
  def theme_photo(theme_id)
    Theme.theme_photo(theme_id)
  end

end

