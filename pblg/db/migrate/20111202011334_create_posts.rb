class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title, :limit => 50
      t.string :body
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end

