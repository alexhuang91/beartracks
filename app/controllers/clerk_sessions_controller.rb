class ClerkSessionsController < ApplicationController
  
  def new
    @clerk_session = ClerkSession.new
  end

  def create
    @clerk_session = ClerkSession.new(params[:clerk_session])
    if @clerk_session.save
      flash[:notice] = "Login success."
      redirect_to root_url
    else
      render :action => :new
    end
  end

end
