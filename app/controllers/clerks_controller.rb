class ClerksController < ApplicationController
  
  def new
    @clerk = Clerk.new
  end
  
  def create
    @clerk = Clerk.new(params[:clerk])
    if @clerk.save
      flash[:notice] = "Clerk account successfully created."
      redirect_to root_url
    else
      flash[:error] = "There was an error creating this user."
      render :action => :new
    end
  end
  
end
