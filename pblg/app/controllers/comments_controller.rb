class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params[:comment])

    if @comment.save
      redirect_to(@comment.post, :notice => "#{@comment.title} was successfully created.")
    else
      render('new')
    end
  end

end

