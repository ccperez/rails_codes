class Jobolicious::Job < Jobolicious::Db
  has_many :jobs_categories, :dependent => :destroy
  has_many :categories, :through => :jobs_categories

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  URL_REGEX =  /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/

  validates_presence_of :company, :email, :url, :title,
    :location, :description, :to_apply, :categories

  validates_length_of :company, :location, :maximum => 100
  validates_length_of :email, :url, :maximum => 150
  validates_length_of :to_apply, :maximum => 200

  validates_format_of :email, :with => EMAIL_REGEX
  validates_format_of :url,   :with => URL_REGEX

  # validate :has_categories?

  # def has_categories?
  #  errors.add_to_base(:categories, "must have some categories.") if (categories.length < 1)
  # end

  def self.search(search=nil, category=nil)
    select = "SELECT
               jobolicious_jobs.id,
               jobolicious_jobs.location,
               jobolicious_jobs.title,
               jobolicious_jobs.company,
               jobolicious_jobs.description,
               jobolicious_jobs.url "
      from = " FROM jobolicious_jobs"
     where = " WHERE jobolicious_jobs.id > 0
                 AND DATE_ADD(created_at, INTERVAL 30 DAY ) > NOW() "
     order = " ORDER BY jobolicious_jobs.id DESC"

    if !search.empty?
      select = "#{select}, match(title,location,description)
                  against ('#{search}' IN BOOLEAN MODE)
                  as relevance "
       where = "#{where} AND match(title,location,description) against
                  ('#{search}' IN BOOLEAN MODE) "
       order = " ORDER BY relevance DESC"
    end

    if !category.empty?
       from = "#{from}, jobolicious_jobs_categories"
      where = "#{where}
               AND jobolicious_jobs.id = jobolicious_jobs_categories.job_id
               AND jobolicious_jobs_categories.category_id = '#{category}'"
    end

    sql = "#{select}#{from}#{where}#{order}"

    find_by_sql(sql)
  end

end

