class SectionsController < ApplicationController
  layout 'admin'

  before_filter :confirm_logged_in
  before_filter :get_fields, :check_event, :except => [:index]
  before_filter :find_page

  def index
    @sections = Section.sorted.where(:page_id => @page.id)
    @tHdr = ['Section','Visible','Content Type']
    @fields = ['position','name', 'visible']
  end

  def manage
    if request.get? && !params[:id].blank?   # show /edit
      @section = Section.find(params[:id])
      if params[:event] == "edit"
        @section_count = @page.sections.size
        @pages = Page.sorted
      end
    elsif request.get? && params[:id].blank? # new
      @section = Section.new(:page_id => @page.id)
      @section_count = @page.sections.size + 1
      @pages = Page.sorted
    elsif request.post? && params[:id].blank?   # create
      new_position = params[:section].delete(:position)
      @section = Section.new(params[:section])
      data = @section.save
      update_data(data, new_position)
    elsif request.post? && !params[:id].blank?  # edit / delete / destroy
      new_position = params[:section].delete(:position) if params[:commit] =~ /Update(.*)/
      @section = Section.find(params[:id])
      @section.move_to_position(nil) if params[:commit] =~ /Delete(.*)/
      data = (params[:commit] =~ /Update(.*)/) ? @section.update_attributes(params[:section]) : @section.destroy
      update_data(data, new_position)
    end
  end

  private #-

  def get_fields
    @fields = Section.find_by_sql("DESC sections")
  end

  def find_page
    @page = Page.find_by_id(params[:page_id]) if params[:page_id]
  end

  def update_data(check_data, position)
    if check_data
      save_editor_section if position
      @section.move_to_position(position) if position
      redirect('Section', {:action => 'index', :page_id => @page.id})
    else
      @section_count = (!params[:id].blank?) ? @page.sections.size : @page.sections.size + 1
      @pages = Page.sorted
    end
  end

  def save_editor_section
    edit = SectionEdit.where(:admin_user_id => session[:user_id], :section_id => params[:id])
    editor = SectionEdit.find(edit).destroy if !edit.empty?
    SectionEdit.create(:admin_user_id => session[:user_id], :section => @section, :summary => @section.name)
  end

end

