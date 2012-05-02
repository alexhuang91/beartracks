class ClerksController < ApplicationController
  
  before_filter :is_admin?, :only => [:new, :create, :index, :show, :toggle_admin_access]
  before_filter :check_id_access, :only => [:edit, :update]
  
  def index
    @my_id = current_clerk.id
    @clerks = Clerk.all  
  end
  
  def new
    @new = true
    @clerk = Clerk.new
  end
  
  def show
    # Use find_by_id instead of find so that it will return nil instead of throwing an exception
    @clerk = Clerk.find_by_id(params[:id])

    # If the clerk doesn't exist, go back to the clerks page
    if @clerk.nil?
      flash[:notice] = "The clerk you requested doesn't exist."
      redirect_to clerks_path
    end
  end

  def create
    @clerk = Clerk.new(params[:clerk])
    if @clerk.save
      flash[:notice] = "Clerk account successfully created."
      redirect_to clerks_path
    else
      if @clerk.errors.any?
        flash[:error] = html_list("Please fix the following errors:\n", @clerk.errors.full_messages)
      else
        flash[:error] = "There was a problem. Please try again."
      end
      redirect_to new_clerk_path
    end
  end
  
  def edit
    @new = false
    @clerk = Clerk.find(params[:id])
  end
  
  def update 
    @clerk = Clerk.find(params[:id])
    @clerk.update_attributes(params[:clerk]) # don't worry we're protected from is_admin by attr_protected
    if @clerk.errors.any?
      flash[:error] = html_list("Please fix the following errors:\n", @clerk.errors.full_messages)
      redirect_to edit_clerk_path(@clerk)
    else
      # If password was not updated, go back to the show profile page
      # Otherwise, go to the home page and flash a notice
      if params[:clerk][:password] == ""
        flash[:notice] = "#{@clerk.login} was successfully updated."
        redirect_to clerk_path(@clerk)
      else # password was updated, clerk will be automatically logged out anyway so redirect to home page with a notice
        flash[:notice] = "Your password was changed. Please log in again."
        redirect_to root_url
      end
    end
  end
  
  def toggle_admin_access
    clerk = Clerk.find params[:id]
    
    if clerk.is_admin?
      clerk.is_admin = false

      if clerk.save
        flash[:notice] = "#{clerk.first_name} #{clerk.last_name} has lost admin privileges."
        redirect_to clerks_path
      else
        flash[:warning] = "Error in revoking admin privileges. Try again."
        redirect_to clerks_path
      end
    else # clerk is not an admin
      clerk.is_admin = true

      if clerk.save
        flash[:notice] = "#{clerk.first_name} #{clerk.last_name} has been granted admin privileges."
        redirect_to clerks_path
      else
        flash[:warning] = "Error in granting admin privileges. Try again."
        redirect_to clerks_path
      end 
    end
  end

  protected
  
  def is_admin?
    if current_clerk.nil? or not current_clerk.is_admin?
      flash[:warning] = "You must have admin privileges to do that."
      redirect_to packages_path
      return false
    end
    return true
  end
  
  # Only admins will be able to edit a clerk's profile
  def check_id_access
    target_clerk = Clerk.find_by_id(params[:id])
    
    # Nil check, but if this fails then something bad is going on
    if not current_clerk.nil? and not target_clerk.nil? 
      if current_clerk.is_admin?
        if target_clerk.is_admin? and target_clerk.id != current_clerk.id
          flash[:warning] = "You can't edit another admin's profile."
          redirect_to clerks_path
          return false
        else # Trying to edit a regular clerk's profile
          return true
        end
      else # Not an admin, so can't edit anyone's profile, including your own
        flash[:warning] = "You can't edit your own profile. Please ask your supervisor." 
        redirect_to clerk_home_path
        return false
      end
    end
  end
  
end
