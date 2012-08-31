class CreateFotoweeklyPhotos < ActiveRecord::Migration
  def self.up
    create_table :fotoweekly_photos do |t|
      t.integer  "theme_id"
      t.string   "title",        :limit =>  50
      t.string   "fullname",     :limit =>  40
      t.string   "discuss_url" , :limit => 150
      t.string   "email",        :limit => 100
      t.integer  "vote_cache"
      t.datetime "created_at"
    end
  end

  def self.down
    drop_table :fotoweekly_photos
  end
end

