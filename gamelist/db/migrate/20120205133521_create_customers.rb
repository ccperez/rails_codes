class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string 'payer_id',        :limit => 20
      t.string 'first_name',      :limit => 100
      t.string 'last_name',       :limit => 100
      t.string 'payer_email',     :limit => 150
      t.string 'address_country', :limit => 100
      t.string 'address_street',  :limit => 100
      t.string 'address_city',    :limit => 100
      t.string 'address_zip',     :limit => 10
      t.string 'address_state',   :limit => 100
      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end

