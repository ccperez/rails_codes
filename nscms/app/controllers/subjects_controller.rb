class SubjectsController < ApplicationController
  layout 'admin'

  before_filter :confirm_logged_in
  before_filter :get_fields, :check_event, :except => :index

  def index
    @subjects = Subject.sorted
    @tHdr   = ['Subject', 'Visible', 'Pages']
    @fields = ['position', 'name', 'visible']
  end

  def manage
    if request.get? && !params[:id].blank?     # show / edit / delete
      @subject = Subject.find(params[:id])
      @subject_count = Subject.count if params[:event] == "edit"
    elsif request.get? && params[:id].blank?   # new
      @subject = Subject.new
      @subject_count = Subject.count + 1
    elsif request.post? && params[:id].blank?  # create
      new_position = params[:subject].delete(:position)
      @subject = Subject.new(params[:subject])
      data = @subject.save
      update_data(data, new_position)
    elsif request.post? && !params[:id].blank? # update / destroy
      new_position = params[:subject].delete(:position) if params[:commit] =~ /Update(.*)/
      @subject = Subject.find(params[:id])
      @subject.move_to_position(nil) if params[:commit] =~ /Delete(.*)/
      data = (params[:commit] =~ /Update(.*)/) ? @subject.update_attributes(params[:subject]) : @subject.destroy
      update_data(data, new_position)
    end
  end

  private #-

  def get_fields
    @fields = Subject.find_by_sql("DESC subjects")
  end

  def update_data(check_data, position)
    if check_data
      @subject.move_to_position(position) if position
      redirect('Subject')
    else
      @subject_count = (!params[:id].blank?) ? Subject.count : Subject.count + 1
    end
  end

end

