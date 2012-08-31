class CreatePaymentNotifications < ActiveRecord::Migration
  def self.up
     create_table :payment_notifications do |t|
      t.text :params
      t.string :payment_status, :limit => 50
      t.string :txn_id,         :limit => 20
      t.timestamps
    end
  end

  def self.down
    drop_table :payment_notifications
  end
end

