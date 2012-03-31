class ClerkSessionsController < ApplicationController
  
  def new
    @clerk_session = ClerkSession.new
  end

  def create
    @clerk_session = ClerkSession.new(params[:clerk_session])
    if @clerk_session.save
      flash[:notice] = "You have successfully logged in."
      redirect_to root_url
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

end
