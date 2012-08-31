class Fotoweekly::Photo < Fotoweekly::Db
  belongs_to :theme
  # has_and_belongs_to_many :tags, :join_table => "fotoweekly_photos_tags"
  has_many :photos_tags, :dependent => :destroy
  has_many :tags, :through => :photos_tags

  accepts_nested_attributes_for :tags, :reject_if => proc {|attributes| attributes[:name].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :photos_tags, :reject_if => proc {|attributes| attributes[:tag_attributes][:name].blank? }, :allow_destroy => true

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  URL_REGEX =  /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/

  validates_presence_of :title, :fullname, :discuss_url, :email

  validates_format_of :email, :with => EMAIL_REGEX
  validates_format_of :discuss_url, :with => URL_REGEX

  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/pjpeg']
  validates_attachment_size :image, :less_than => 1.megabytes,
        :if => Proc.new { |imports| !imports.image.file?}

  # Paperclip
  has_attached_file :image,
    :styles => {
      :small  => "75x75#",
      :medium => "240x240>",
      :large  => "500x350>"
    },
    :url => "/app/assets/images/fotoweekly/photos/:style/:id.:extension",
    :path => ":rails_root/app/assets/images/fotoweekly/photos/:style/:id.:extension"


  def self.find_photos_by_theme(theme_id)
    where(:theme_id => theme_id).order('vote_cache DESC')
  end

  def self.find_photos_by_tag(tag)
    query = "
      SELECT
        fotoweekly_photos.id,
        fotoweekly_photos.title,
        fotoweekly_photos.theme_id,
        fotoweekly_photos.created_at,
        fotoweekly_photos.fullname,
        fotoweekly_photos.vote_cache,
        fotoweekly_themes.name as theme
      FROM fotoweekly_photos
      JOIN fotoweekly_themes ON fotoweekly_photos.theme_id = fotoweekly_themes.id
      JOIN fotoweekly_photos_tags ON fotoweekly_photos.id = fotoweekly_photos_tags.photo_id
      JOIN fotoweekly_tags ON fotoweekly_photos_tags.tag_id = fotoweekly_tags.id
     WHERE fotoweekly_tags.name = '#{tag}'
     ORDER BY vote_cache DESC"

    find_by_sql(query)
  end

  def self.photo_tags(id)
    query = "
      SELECT fotoweekly_tags.id, name, COUNT(*) as count
        FROM fotoweekly_tags
        JOIN fotoweekly_photos_tags
          ON fotoweekly_tags.id = fotoweekly_photos_tags.tag_id
       WHERE photo_id = #{id}
       GROUP BY tag_id"

    find_by_sql(query)
  end

  def self.create_photo_tag(tags, id)
    photo_tags = tags.split(', ')
    photo_tags.each do |photo_tag|
      if !photo_tag.strip.empty?
        name = photo_tag.strip
        tag = Fotoweekly::Tag.find_or_create_by_name(name)
        photo = Fotoweekly::Photo.find(id)
        photo.tags << tag
      end
    end
  end

  def self.photo_vote(id, ip)
    # vote_query = "
    #   SELECT id FROM fotoweekly_photos_votes
    #    WHERE ip_address = '#{ip}'
    #      AND photo_id   = '#{id}'"
    # vote = false
    # if find_by_sql(vote_query).empty?
    #   insert_vote = "
    #     INSERT INTO fotoweekly_photos_votes
    #      (photo_id, ip_address, created_at)
    #     VALUES ('#{id}','#{ip}', now())"
    #   Fotoweekly::Db.connection.execute(insert_vote)
    #   update_vote_cache = "
    #     UPDATE fotoweekly_photos set vote_cache =
    #      (SELECT count(*) as count
    #         FROM fotoweekly_photos_votes
    #        WHERE photo_id=#{id})
    #     WHERE id= #{id}"
    #   Fotoweekly::Db.connection.execute(update_vote_cache)
    # end

    photoVote = Fotoweekly::PhotosVotes.where(:photo_id => id, :ip_address => ip)
    vote = false
    if photoVote.blank?
      Fotoweekly::PhotosVotes.create(:photo_id => id, :ip_address => ip)
      photo = Fotoweekly::Photo.find(id)
      photo.vote_cache = Fotoweekly::PhotosVotes.where(:photo_id => id).count
      photo.save
      vote = true
    end
    return vote
  end

end

