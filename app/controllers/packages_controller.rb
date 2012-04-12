class PackagesController < ApplicationController
  
  before_filter :clerk_check
  
  def show
    @package = Package.find params[:id]
    @clerk_received = Clerk.find @package.clerk_received_id
    if @package.picked_up
      @accepted = true
      @clerk_released = Clerk.find @package.clerk_accepted_id
    end
  end

  def index
    if params[:unit] != session[:unit] or params[:packages] != session[:packages]
      session[:unit]     = params[:unit]     || session[:unit]
      session[:packages] = params[:packages] || session[:packages]
      flash.keep
      redirect_to :unit=>session[:unit], :packages=>session[:packages] and return
    end
    if not params[:unit] or not params[:packages]
      session[:unit]     = 'all' unless params[:unit]
      session[:packages] = 'all' unless params[:packages]
      flash.keep
      redirect_to :unit=>session[:unit], :packages=>session[:packages] and return
    end

    # Do we want a clerk to be able to see all the packages at all the units?
    # I'm thinking maybe we can limit them to just the unit they work at.
    # If we don't want them to see everything, just remove everything that's commented
    # out below between the TODO tags, and also remove all the unit stuff above
    # TODO ===========================================================================
    
    #units = params[:unit] == 'all' ? units_array : params[:unit]
    #@units_hash = Hash[units_array.collect { |u| [u,u] }]
    #@units_hash['All Units'] = 'all'
    @packages_hash = {'Not picked up'=>'received', 'Picked up'=>'picked_up', 'All Packages'=>'all'}

    if params[:packages] == 'received'
      @packages = Package.where :picked_up => false #, :unit => units
    elsif params[:packages] == 'picked_up'
      @packages = Package.where :picked_up => true #, :unit => units 
    else
      @packages = Package.all #Package.where :unit => units
    end
    
    # TODO ===========================================================================
  end

  def edit
    @new = false
    @package = Package.find params[:id]
  end

  def new
    @new = true
  end

  def create
    p = Package.new params[:package]
    if not p.has_required_fields
      flash[:warning] = "Cannot leave #{p.blank_fields} blank"
      redirect_to new_package_path
    else
      p.datetime_received = Time.now.to_datetime
      # This will let use do "p.clerk" to access a package's clerk 
      p.clerk_id = current_clerk.id
      # TODO clerk_received_id is deprecated. remove once everyone knows about clerk_id
      p.clerk_received_id = current_clerk.id
      if p.save
      # TODO Send out an email or text or add to the slip-queue
        flash[:notice] = "Package created successfully."
      else
        flash[:warning] = "There was an error creating this package."
      end
      # Now that the package is saved, redirect to the list of packages if the
      # clerk is done creating them, or another create package form if the
      # clerk wants to create more packages.
      if params[:commit] == "Create Package"
        redirect_to packages_path
      else
        redirect_to new_package_path
      end
    end
  end

  def update
    @package = Package.find params[:id]
    p = params[:package]
    p[:updated_at] = Time.now.to_datetime
    if @package.update_attributes(p)
      flash[:notice] = "Package was updated successfully."
      redirect_to package_path @package
    else
      flash[:warning] = "There was an error in updating this package."
      redirect_to edit_package_path @package
    end
  end

  def destroy
    # what is there to do here, just remove it from the db? but who gets to do this, admins and/or clerks, and when?
    @package = Package.find params[:id]
    @package.destroy
    flash[:notice] = "Package was deleted successfully."
    redirect_to packages_path
  end

  def picked_up
    p = Package.find(params[:id])
    p.picked_up = true
    p.clerk_accepted_id = current_clerk.id
    p.datetime_accepted = Time.now.to_datetime
    if p.save
      flash[:notice] = "Packed was picked up."
      redirect_to packages_path # or to the resident sign-up page if they arent opted in?
    else
      flash[:warning] = "There was an error in updating this package."
      redirect_to package_path p
    end
  end
  
  protected
  
  def clerk_check
    if not clerk_logged_in?
      flash[:warning] = "You must be logged in as a clerk to work with packages."
      redirect_to root_url
      return false
    end
    return true
  end

end
