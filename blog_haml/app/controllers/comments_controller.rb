class CommentsController < ApplicationController
  def index
    @comments = Comment.search(
      params[:post_id],Time.at(params[:after].to_i + 1))
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params[:comment])

    if @comment.save
      flash[:notice] = "Successfully created comment."
      redirect_to(@comment.post)
    else
      render('new')
    end
  end
end

