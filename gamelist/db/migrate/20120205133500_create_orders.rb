class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.references :payment_notification
      t.references :customer
      t.decimal "mc_gross", :null => false, :precision => 8, :scale => 2, :default => 0.00
      t.datetime :created_at
    end
  end

  def self.down
    drop_table :orders
  end
end

