class CreateCategoriesJobsJoin < ActiveRecord::Migration
  def self.up
    create_table :categories_jobs, :id => false do |t|
      t.integer "category_id"
      t.integer "job_id"
    end
    add_index :categories_jobs, ["category_id", "job_id"]
  end

  def self.down
    drop_table :categories_jobs
  end
end

