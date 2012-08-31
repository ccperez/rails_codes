class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :post_id
      t.string :title,  :limit => 50
      t.string :email, :limit => 50
      t.string :body,  :limit => 100
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end

