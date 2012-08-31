# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20120411112113) do

  create_table "blog_posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fotoweekly_photos", :force => true do |t|
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

  create_table "fotoweekly_photos_tags", :force => true do |t|
    t.integer "photo_id"
    t.integer "tag_id"
  end

  add_index "fotoweekly_photos_tags", ["photo_id", "tag_id"], :name => "index_fotoweekly_photos_tags_on_photo_id_and_tag_id"

  create_table "fotoweekly_photos_votes", :force => true do |t|
    t.integer  "photo_id"
    t.string   "ip_address", :limit => 20
    t.datetime "created_at"
  end

  create_table "fotoweekly_tags", :force => true do |t|
    t.string "name", :limit => 30
  end

  create_table "fotoweekly_themes", :force => true do |t|
    t.string   "name",        :limit => 50
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gamelist_customers", :force => true do |t|
    t.string   "payer_id",        :limit => 20
    t.string   "first_name",      :limit => 100
    t.string   "last_name",       :limit => 100
    t.string   "payer_email",     :limit => 150
    t.string   "address_country", :limit => 100
    t.string   "address_street",  :limit => 100
    t.string   "address_city",    :limit => 100
    t.string   "address_zip",     :limit => 10
    t.string   "address_state",   :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gamelist_items", :force => true do |t|
    t.integer "order_id",                                                  :null => false
    t.integer "product_id",                                                :null => false
    t.integer "quantity",                                                  :null => false
    t.decimal "price",      :precision => 8, :scale => 2, :default => 0.0, :null => false
  end

  create_table "gamelist_orders", :force => true do |t|
    t.integer  "gamelist_payment_notification_id"
    t.integer  "gamelist_customer_id"
    t.decimal  "mc_gross",                         :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.datetime "created_at"
  end

  create_table "gamelist_payment_notifications", :force => true do |t|
    t.text     "params"
    t.string   "payment_status", :limit => 50
    t.string   "txn_id",         :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gamelist_products", :force => true do |t|
    t.string  "title", :limit => 100,                               :default => "Untitled",    :null => false
    t.string  "body",  :limit => 100,                                                          :null => false
    t.decimal "price",                :precision => 8, :scale => 2, :default => 0.0,           :null => false
    t.string  "image", :limit => 50,                                :default => "nophoto.jpg", :null => false
  end

  create_table "jobolicious_categories", :force => true do |t|
    t.string "name", :limit => 100
  end

  create_table "jobolicious_jobs", :force => true do |t|
    t.string   "title",       :limit => 100, :default => "Untitled"
    t.text     "description"
    t.string   "location",    :limit => 100
    t.string   "company",     :limit => 100
    t.string   "url",         :limit => 150
    t.string   "to_apply",    :limit => 200
    t.string   "email",       :limit => 150
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobolicious_jobs_categories", :force => true do |t|
    t.integer "job_id"
    t.integer "category_id"
  end

  add_index "jobolicious_jobs_categories", ["job_id", "category_id"], :name => "index_jobolicious_jobs_categories_on_job_id_and_category_id"

end
