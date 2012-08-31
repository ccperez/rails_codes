class Theme < ActiveRecord::Base
  has_many :photos

  scope :sorted, order('themes.id DESC')

  def self.theme_photo(theme_id)
    query = "
      SELECT photos.id
        FROM themes, photos
       WHERE themes.id = photos.theme_id
         AND photos.theme_id = #{theme_id}
       ORDER BY photos.vote_cache DESC"

    find_by_sql(query).first

  end

end

