class Job < ActiveRecord::Base
  has_and_belongs_to_many :categories

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  URL_REGEX =  /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix

  validates_presence_of :company, :email, :url,
    :title, :location, :description, :to_apply

  validates_length_of :company, :location, :maximum => 100
  validates_length_of :email, :url, :maximum => 150
  validates_length_of :to_apply, :maximum => 200

  validates_format_of :email, :with => EMAIL_REGEX
  validates_format_of :url,   :with => URL_REGEX

  def self.search(search=nil, category=nil)
    select = "SELECT
               jobs.id,
               jobs.location,
               jobs.title,
               jobs.company,
               jobs.description,
               jobs.url "
      from = " FROM jobs"
     where = " WHERE id > 0
                 AND DATE_ADD(created_at, INTERVAL 30 DAY ) > NOW() "
     order = " ORDER BY id DESC"

    if !search.empty?
      select = "#{select}, match(title,location,description)
                  against ('#{search}' IN BOOLEAN MODE)
                  as relevance "
       where = "#{where} AND match(title,location,description) against
                  ('#{search}' IN BOOLEAN MODE) "
       order = " ORDER BY relevance DESC"
    end

    if !category.empty?
       from = "#{from}, categories_jobs"
      where = "#{where}
               AND jobs.id = categories_jobs.job_id
               AND categories_jobs.category_id = '#{category}'"
    end

    sql = "#{select}#{from}#{where}#{order}"

    find_by_sql(sql)
  end

end

