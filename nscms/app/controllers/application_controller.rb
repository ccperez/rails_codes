class ApplicationController < ActionController::Base
  protect_from_forgery

  protected #

  def redirect(object, redirect = {:action => 'index'})
    event = ((params[:commit] =~ /Delete(.*)/) ? "deleted." : (params[:id].blank? ? "created." : "updated."))
    # flash[:notice] = "#{object} was successfully #{event}"
    redirect_to(redirect, :notice => "#{object} was successfully #{event}")
  end

  def check_event
    event = %w[show new create edit delete]
    redirect_to(:action => 'index') if params[:event].blank? || !event.include?(params[:event])
  end

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in."
      redirect_to(:controller => 'access', :action => 'login')
      return false # halts the before_filter
    else
      return true
    end
  end

end

