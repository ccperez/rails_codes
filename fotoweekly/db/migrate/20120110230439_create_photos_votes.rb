class CreatePhotosVotes < ActiveRecord::Migration
  def self.up
    create_table :photos_votes do |t|
       t.integer  "photo_id"
       t.string   "ip_address", :limit => 20
       t.datetime "created_at"
    end
  end

  def self.down
    drop_table :photos_votes
  end
end

