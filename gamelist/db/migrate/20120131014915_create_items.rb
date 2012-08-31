class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.integer "order_id",   :null => false
      t.integer "product_id", :null => false
      t.integer "quantity",   :null => false
      t.decimal "price",      :null => false, :precision => 8, :scale => 2, :default => 0.00
    end
  end

  def self.down
    drop_table :items
  end
end

