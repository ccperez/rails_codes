class CreateJoboliciousJobsCategories < ActiveRecord::Migration
  def self.up
    create_table :jobolicious_jobs_categories do |t|
      t.integer "job_id"
      t.integer "category_id"
    end
    add_index :jobolicious_jobs_categories, ['job_id', 'category_id']
  end

  def self.down
    drop_table :jobolicious_jobs_categories
  end
end

