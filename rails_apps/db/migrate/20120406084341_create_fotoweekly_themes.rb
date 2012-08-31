class CreateFotoweeklyThemes < ActiveRecord::Migration
  def self.up
    create_table :fotoweekly_themes do |t|
      t.string "name", :limit => 50
      t.text   "description"
      t.timestamps
    end
  end

  def self.down
    drop_table :fotoweekly_themes
  end
end

