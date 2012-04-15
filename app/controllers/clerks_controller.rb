class ClerksController < ApplicationController
  
  def new
    @clerk = Clerk.new
  end
  
  def show
    
  end

  def create
    @clerk = Clerk.new(params[:clerk])
    if @clerk.save
      ClerkSession.create! @clerk
      flash[:notice] = "Clerk account successfully created."
      redirect_to clerk_home_path
    else
      if @clerk.errors.any?
        flash[:error] = html_list("Please fix the following errors:\n",@clerk.errors.full_messages)
      else
        flash[:error] = "There was a problem. Please try again."
      end
      redirect_to new_clerk_path
    end
  end
  
  def edit
    @clerk = Clerk.find(params[:id])
  end
  
  def update 
    @clerk = Clerk.find(params[:id])
    @clerk.update_attributes(params[:clerk]) # don't worry we're protected from is_admin by attr_protected
    if @clerk.errors.any?
      flash[:error] = html_list("Please fix the following errors:\n", @clerk.errors.full_messages)
      redirect_to edit_clerk_path(@clerk)
    else
      flash[:notice] = "#{@clerk.login} was successfully updated."
      redirect_to clerk_path(@clerk)
    end
  end
  
end
