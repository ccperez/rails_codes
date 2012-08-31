class CreateThemes < ActiveRecord::Migration
  def self.up
    create_table :themes do |t|
      t.string "name", :limit => 50
      t.text   "description"
      t.timestamps
    end
  end

  def self.down
    drop_table :themes
  end
end

