class AdminUsersController < ApplicationController
  layout 'admin'

  before_filter :confirm_logged_in
  before_filter :get_fields, :check_event, :except => :index

  def index
    @admin_users = AdminUser.sorted
    @tHdr   = ['Username', 'Full Name', 'Email']
    @fields = ['username', 'full_name', 'email']
  end

  def manage
    if request.get? && !params[:id].blank?    # show / edit / delete
      @admin_user = AdminUser.find(params[:id])
    elsif request.get? && params[:id].blank?  # new
      @admin_user = AdminUser.new
    elsif request.post? && params[:id].blank? # create
      @admin_user = AdminUser.new(params[:admin_user])
      data = @admin_user.save
      redirect('Admin User') if data
    elsif request.post? && !params[:id].blank? # update / destroy
      @admin_user = AdminUser.find(params[:id])
      data = (params[:commit] =~ /Update(.*)/) ? @admin_user.update_attributes(params[:admin_user]) : @admin_user.destroy
      redirect('Admin User') if data
    end
  end

  private #-

  def get_fields
    @fields = Subject.find_by_sql("DESC admin_users")
  end

end

