# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120112074306) do

  create_table "photos", :force => true do |t|
    t.integer  "theme_id"
    t.string   "title",              :limit => 50
    t.string   "fullname",           :limit => 40
    t.string   "discuss_url",        :limit => 150
    t.string   "email",              :limit => 100
    t.integer  "vote_cache"
    t.datetime "created_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
  end

  add_index "photos", ["theme_id"], :name => "photos_themeID"

  create_table "photos_tags", :id => false, :force => true do |t|
    t.integer "photo_id"
    t.integer "tag_id"
  end

  add_index "photos_tags", ["photo_id"], :name => "photos_tags_photoID"
  add_index "photos_tags", ["tag_id"], :name => "photos_tags_tagID"

  create_table "photos_votes", :force => true do |t|
    t.integer  "photo_id"
    t.string   "ip_address", :limit => 20
    t.datetime "created_at"
  end

  add_index "photos_votes", ["photo_id"], :name => "photos_votes_photoID"

  create_table "tags", :force => true do |t|
    t.string   "name",       :limit => 30
  end

  create_table "themes", :force => true do |t|
    t.string   "name",        :limit => 50
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

