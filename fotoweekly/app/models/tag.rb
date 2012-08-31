class Tag < ActiveRecord::Base
  has_and_belongs_to_many :photos

  def self.find_tags
    query = "
      SELECT tags.id, name, COUNT(*) as count
        FROM tags, photos_tags
       WHERE tags.id = photos_tags.tag_id
       GROUP BY tag_id"

     find_by_sql(query)
  end

end

