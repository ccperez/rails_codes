class CreateGamelistOrders < ActiveRecord::Migration
  def self.up
    create_table :gamelist_orders do |t|
      t.references :gamelist_payment_notification
      t.references :gamelist_customer
      t.decimal    :mc_gross, :null => false, :precision => 8, :scale => 2, :default => 0.00
      t.datetime   :created_at
    end
  end

  def self.down
    drop_table :gamelist_orders
  end

end

