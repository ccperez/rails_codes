class PagesController < ApplicationController
  layout 'admin'

  before_filter :confirm_logged_in
  before_filter :get_fields, :check_event, :except => :index
  before_filter :find_subject

  def index
    @pages = Page.sorted.where(:subject_id => @subject.id)
    @tHdr   = ['Page','Visible','Sections']
    @fields = ['position','name', 'visible']
  end

  def manage
    if request.get? && !params[:id].blank?     # show / edit
      @page = Page.find(params[:id])
      if params[:event] == "edit"
         @page_count = @subject.pages.size
         @subjects = Subject.sorted
      end
    elsif request.get? && params[:id].blank?   # new
      @page = Page.new(:subject_id => @subject.id)
      @page_count = @subject.pages.size + 1
      @subjects = Subject.sorted
    elsif request.post? && params[:id].blank?  # create
      new_position = params[:page].delete(:position)
      @page = Page.new(params[:page])
      data = @page.save
      update_data(data, new_position)
    elsif request.post? && !params[:id].blank? # update / delete / destroy
      new_position = params[:page].delete(:position) if params[:commit] =~ /Update(.*)/
      @page = Page.find(params[:id])
      @page.move_to_position(nil) if params[:commit] =~ /Delete(.*)/
      data = (params[:commit] =~ /Update(.*)/) ? @page.update_attributes(params[:page]) : @page.destroy
      update_data(data, new_position)
    end
  end

  private #-

  def get_fields
    @fields = Page.find_by_sql("DESC pages")
  end

  def find_subject
    @subject = Subject.find_by_id(params[:subject_id]) if params[:subject_id]
  end

  def update_data(check_data, position)
    if check_data
      save_editors_page if position
      @page.move_to_position(position) if position
      redirect('Page', {:action => 'index', :subject_id => @page.subject_id})
    else
      @page_count = (!params[:id].blank?) ? @subject.pages.size : @subject.pages.size + 1
      @subjects = Subject.sorted
    end
  end

  def save_editors_page
    editor = AdminUser.find(session[:user_id])
    if !@page.editors.empty?
      @page.editors.delete
      @page.editors.clear
    end
    @page.editors << editor
  end

end

