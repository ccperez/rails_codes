class CreateFotoweeklyPhotosTags < ActiveRecord::Migration
  def self.up
    create_table :fotoweekly_photos_tags do |t|
       t.integer "photo_id"
       t.integer "tag_id"
    end
    add_index :fotoweekly_photos_tags, ['photo_id', 'tag_id']
  end

  def self.down
    drop_table :fotoweekly_photos_tags
  end
end

