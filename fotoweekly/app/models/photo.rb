# http://tekn0t.net/delete-original-image-when-using-papercliprai

class Photo < ActiveRecord::Base
  belongs_to :theme
  has_and_belongs_to_many :tags

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  URL_REGEX =  /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/

  validates_presence_of :title, :fullname, :discuss_url, :email

  validates_format_of :email, :with => EMAIL_REGEX
  # validates_format_of :discuss_url, :with => URL_REGEX

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
    :url => "/images/photos/:style/:id.:extension",
    :path => ":rails_root/public/images/photos/:style/:id.:extension"

  def self.find_photos_by_theme(theme_id)
    where(:theme_id => theme_id).order('vote_cache DESC')
  end

  def self.find_photos_by_tag(tag)
    query = "
      SELECT
        photos.id,
        photos.title,
        photos.theme_id,
        photos.created_at,
        photos.fullname,
        photos.vote_cache,
        themes.name as theme
      FROM photos, themes,
        tags, photos_tags
     WHERE photos.theme_id = themes.id
       AND photos.id = photos_tags.photo_id
       AND photos_tags.tag_id = tags.id
       AND tags.name = '#{tag}'
     ORDER BY vote_cache DESC"

    find_by_sql(query)
  end

  def self.photo_tags(id)
    query = "
      SELECT tags.id, name, COUNT(*) as count
        FROM tags, photos_tags
       WHERE tags.id = photos_tags.tag_id
         AND photo_id = #{id}
       GROUP BY tag_id"

    find_by_sql(query)
  end

  def self.create_photo_tag(tags, id)
    photo_tags = tags.split(', ')
    photo_tags.each do |photo_tag|
      if !photo_tag.strip.empty?
        name = photo_tag.strip
        # tag = Tag.where(["name=?", name])
        # tag = Tag.create(:name => name) if tag.empty?
        tag = Tag.find_or_create_by_name(name)
        photo = Photo.find(id)
        photo.tags << tag
      end
    end
  end

  def self.photo_vote(id, ip)
    photeVote = PhotosVotes.where(:photo_id => id, :ip_address => ip)

    vote = false
    if photeVote.blank?
      PhotosVotes.create(:photo_id => id, :ip_address => ip)

      photo = Photo.find(id)
      photo.vote_cache = PhotosVotes.where(:photo_id => id).count
      photo.save

      vote = true
    end
    return vote
  end

end

