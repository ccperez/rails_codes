class CreateFotoweeklyPhotosVotes < ActiveRecord::Migration
  def up
    create_table :fotoweekly_photos_votes do |t|
       t.integer  "photo_id"
       t.string   "ip_address", :limit => 20
       t.datetime "created_at"
    end
  end

  def down
    drop_table :fotoweekly_photos_votes
  end
end

