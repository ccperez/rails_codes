class CreateJoboliciousCategories < ActiveRecord::Migration
  def self.up
    create_table :jobolicious_categories do |t|
      t.string "name", :limit => 100
    end
  end

  def self.down
    drop_table :jobolicious_categories
  end
end

