class ClerkSessionsController < ApplicationController
  
  before_filter :no_resident_logged_in, :only => [:new, :create]
  
  def new
    @clerk_session = ClerkSession.new
  end

  def create
    @clerk_session = ClerkSession.new(params[:clerk_session])
    if @clerk_session.save
      flash[:notice] = "You have successfully logged in."
      redirect_to packages_path
    else
      flash[:warning] = "There was an error logging in.  Please try again."
      render :action => :new
    end
  end
  
  def destroy
    if current_clerk_session.nil?
      redirect_to root_url
    else
      current_clerk_session.destroy
      flash[:notice] = "You have successfully logged out."
      redirect_to root_url
    end
  end
  
  protected
  
  def no_resident_logged_in
    if current_resident_session.nil? 
      return true
    end
    flash[:warning] = "You cannot log in as a clerk if you're logged in as a resident."
    redirect_to root_url
    return false
  end

end
