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

ActiveRecord::Schema.define(:version => 20120205133521) do

  create_table "customers", :force => true do |t|
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

  create_table "items", :force => true do |t|
    t.integer "order_id",                                                  :null => false
    t.integer "product_id",                                                :null => false
    t.integer "quantity",                                                  :null => false
    t.decimal "price",      :precision => 8, :scale => 2, :default => 0.0, :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "payment_notification_id"
    t.integer  "customer_id"
    t.decimal  "mc_gross",                :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.datetime "created_at"
  end

  add_index "orders", ["customer_id"], :name => "orders_customerID"
  add_index "orders", ["payment_notification_id"], :name => "orders_paymentNotificationID"

  create_table "payment_notifications", :force => true do |t|
    t.text     "params"
    t.string   "payment_status", :limit => 50
    t.string   "txn_id",         :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string  "title", :limit => 100,                               :default => "Untitled",    :null => false
    t.string  "body",  :limit => 100,                                                          :null => false
    t.decimal "price",                :precision => 8, :scale => 2, :default => 0.0,           :null => false
    t.string  "image", :limit => 50,                                :default => "nophoto.jpg", :null => false
  end

end
