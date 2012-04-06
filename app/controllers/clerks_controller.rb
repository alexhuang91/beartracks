class ClerksController < ApplicationController
  
  def new
    @clerk = Clerk.new
  end
  
  def create
    @clerk = Clerk.new(params[:clerk])
    if @clerk.save
      ClerkSession.create! @clerk
      flash[:notice] = "Clerk account successfully created."
      redirect_to clerk_home_path
    else
      flash[:error] = "There was an error creating this user."
      render :action => :new
    end
  end
  
end
