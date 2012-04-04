class ResidentSessionsController < ApplicationController

  def new
    @resident_session = ResidentSession.new
  end

  def create
    @resident_session = ResidentSession.new(params[:resident_session])
    if @resident_session.save
      flash[:notice] = "You have successfully logged in."
      redirect_to root_url
    else
      flash[:notice] = "There was an error logging in. Please try again."
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
end
