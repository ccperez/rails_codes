class PostsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]

  def index
    @posts = Post.search(params[:search]).
      paginate(:per_page=>2, :page=>params[:page])

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml  => @posts }
      format.json { render :json => @posts }
      format.atom # index.atom.builder
      format.js
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new(:post_id => @post.id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      redirect_to(@post, :notice => "#{@post.title} post was successfully created.")
    else
      render('new')
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to(@post, :notice => "#{@post.title} post was successfully updated.")
    else
      render('edit')
    end
  end

  def delete
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id]).destroy
    redirect_to(posts_url, :notice => "#{@post.title} post was deleted.")
  end

  private #-

  def authenticate
    authenticate_or_request_with_http_basic do |name, password|
      name == "admin" && password == "secret"
    end
  end

end

