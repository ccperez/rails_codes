class JobsController < ApplicationController

  layout('public')

  def index
    search   = params[:search]   ? params[:search]   : ''
    category = params[:category] ? params[:category] : ''

    @jobs = Job.search(search, category)
    @categories = Category.order("name ASC")

    respond_to do |format|
      format.html
      format.atom
    end

  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
    @categories = Category.order("name ASC")
  end

  def create
    @job = Job.new(params[:job])

    if @job.save
      check_categories_using(params[:categories]) if params[:categories]
      redirect_to(jobs_path, :notice => "#{@job.title} was successfully created.")
    else
      @categories = Category.order("name ASC")
      render('new')
    end
  end

  private #

  def check_categories_using(category_id_array)
    checked_categories = []
    checked_params = category_id_array || []
    for check_box_id in checked_params
      category = Category.find(check_box_id)
      if not @job.categories.include?(category)
         @job.categories << category
      end
      checked_categories << category
    end
    return checked_categories
  end
end

