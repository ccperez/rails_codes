class PostsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]
  before_filter :get_post, :only => [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    # @post = Post.find(params[:id])
    @comment = Comment.new(:post_id => @post.id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      redirect_to(@post, :notice => "#{@post.title} was successfully created.")
    else
      render('new')
    end
  end

  def edit
    # @post = Post.find(params[:id])
  end

  def update
    # @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to(@post, :notice => "#{@post.title} was successfully updated.")
    else
      render('edit')
    end
  end

  def destroy
    @post.destroy
    redirect_to(posts_url, :notice => "#{@post.title} was deleted.")
  end

  private #

  def get_post
    @post = Post.find(params[:id])
  end

  def authenticate
    authenticate_or_request_with_http_basic do |name, password|
      name == "admin" && password == "secret"
    end
  end

end

