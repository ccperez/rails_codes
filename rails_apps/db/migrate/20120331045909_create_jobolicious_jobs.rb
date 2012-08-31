class CreateJoboliciousJobs < ActiveRecord::Migration
  def self.up
    create_table :jobolicious_jobs do |t|
      t.string "title",       :limit => 100, :default => "Untitled"
      t.text   "description"
      t.string "location",    :limit => 100
      t.string "company",     :limit => 100
      t.string "url",         :limit => 150
      t.string "to_apply",    :limit => 200
      t.string "email",       :limit => 150
      t.timestamps
    end
  end

  def self.down
    drop_table :jobolicious_jobs
  end
end

