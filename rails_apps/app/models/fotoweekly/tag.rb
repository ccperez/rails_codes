class Fotoweekly::Tag < Fotoweekly::Db
  # has_and_belongs_to_many :photos, :join_table => "fotoweekly_photos_tags"
  has_many :photos_tags, :dependent => :destroy
  has_many :photos, :through => :photos_tags

  def self.find_tags
    query = "
      SELECT fotoweekly_tags.id, name, COUNT(*) as count
        FROM fotoweekly_tags
        JOIN fotoweekly_photos_tags
       WHERE fotoweekly_tags.id = fotoweekly_photos_tags.tag_id
       GROUP BY tag_id"

    find_by_sql(query)
  end

end

