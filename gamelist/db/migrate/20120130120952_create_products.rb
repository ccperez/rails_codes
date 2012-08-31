class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string  "title", :null => false, :limit => 100, :default => "Untitled"
      t.string  "body",  :null => false, :limit => 100
      t.decimal "price", :null => false, :precision => 8, :scale => 2, :default => 0.00
      t.string  "image", :null => false, :limit => 50,  :default => "nophoto.jpg"
    end
  end

  def self.down
    drop_table :products
  end
end

