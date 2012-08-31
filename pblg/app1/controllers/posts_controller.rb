class PostsController < ApplicationController
  # before_filter :authenticate, :except => [:index, :show]

  def index
    @posts = Post.all
  end

  def manage
    if request.get? && !params[:id].blank? #show
      @post = Post.find(params[:id])
      @comment = Comment.new(:post_id => @post.id)
      render('show')
    elsif request.get? && params[:id].blank? #new
      @post = Post.new
      render("new")
    #elsif request.get? && !params[:id].blank? #edit
    #  @post = Post.find(params[:id])
    end
  end


  def create
    @post = Post.new(params[:post])

    if @post.save
      redirect_to(@post, :notice => "#{@post.title} was successfully created.")
    else
      render('new')
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to(@post, :notice => "#{@post.title} was successfully updated.")
    else
      render('edit')
    end
  end

  def destroy
    @post.destroy
    redirect_to(posts_url, :notice => "#{@post.title} was deleted.");
  end

  private #-

  def authenticate
    authenticate_or_request_with_http_basic do |name, password|
      name == "admin" && password == "secret"
    end
  end

end

