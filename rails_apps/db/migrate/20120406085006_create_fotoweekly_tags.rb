class CreateFotoweeklyTags < ActiveRecord::Migration
  def self.up
    create_table :fotoweekly_tags do |t|
      t.string "name", :limit => 30
    end
  end

  def self.down
    drop_table :fotoweekly_tags
  end
end

