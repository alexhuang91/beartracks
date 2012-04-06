class ResidentSessionsController < ApplicationController
  
  before_filter :no_clerk_logged_in, :only => [:new, :create]
  
  def new
    @resident_session = ResidentSession.new
  end

  def create
    @resident_session = ResidentSession.new(params[:resident_session])
    if @resident_session.save
      flash[:notice] = "You have successfully logged in."
      redirect_to root_url
    else
      flash[:warning] = "There was an error logging in. Please try again."
      render :action => :new
    end
  end

  def destroy
    if current_resident_session.nil?
      redirect_to root_url
    else
      current_resident_session.destroy
      flash[:notice] = "You have successfully logged out."
      redirect_to root_url
    end
  end
  
  protected
  
  def no_clerk_logged_in
    if current_clerk_session.nil? 
      return true
    end
    redirect_to packages_path, :warning => "You cannot log in as a resident if you're logged in as a clerk."
    return false
  end
  
end
