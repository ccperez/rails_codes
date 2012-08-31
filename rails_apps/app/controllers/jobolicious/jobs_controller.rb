class Jobolicious::JobsController < ApplicationController

  layout("jobolicious")

  def index
    search   = params[:search]   ? params[:search]   : ''
    category = params[:category] ? params[:category] : ''

    @jobs = Jobolicious::Job.search(search, category)
    @categories = Jobolicious::Category.order("name ASC")

    respond_to do |format|
      format.html
      format.atom
    end
  end

  def show
    @job = Jobolicious::Job.find(decode(params[:id]))
  end

  def new
    @job = Jobolicious::Job.new
    @categories = Jobolicious::Category.order("name ASC")
  end

  def create
    @job = Jobolicious::Job.new(params[:jobolicious_job])
    check_categories_using(params[:categories]) if params[:categories]
    if @job.save
      redirect_to(jobolicious_jobs_path, :notice => "#{@job.title} was successfully created.")
    else
      @categories = Jobolicious::Category.order("name ASC")
      render('new')
    end
  end

  private #

  def check_categories_using(category_id_array)
    checked_categories = []
    checked_params = category_id_array || []
    for check_box_id in checked_params
      category = Jobolicious::Category.find(check_box_id)
      if not @job.categories.include?(category)
         @job.categories << category
      end
      checked_categories << category
    end
    return checked_categories
  end

end

