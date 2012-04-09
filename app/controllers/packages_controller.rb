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

    units = params[:unit] == 'all' ? units_array : params[:unit]
    @units_hash = Hash[units_array.collect { |u| [u,u] }]
    @units_hash['All Units'] = 'all'
    @packages_hash = {'In House'=>'received', 'Picked Up'=>'picked_up', 'All Packages'=>'all'}

    if params[:packages] == 'received'
      @packages = Package.where :datetime_accepted => nil, :unit => units
    elsif params[:packages] == 'picked_up'
      @packages = Package.where("datetime_accepted not ? and unit in (?)", nil, units)
    else
      @packages = Package.where :unit => units
    end
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
      p[:clerk_received_id] = current_clerk.id
      if p.save
      # TODO Send out an email or text or add to the slip-queue
        flash[:notice] = "package #{p.tracking_number} for #{p.resident_name} was created at #{p.datetime_received.localtime.ctime}"
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
      flash[:notice] = "package #{@package.tracking_number} for #{@package.resident_name} was updated #{@package.updated_at.localtime.ctime}}"
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
    flash[:notice] = "package was deleted."
    redirect_to packages_path
  end

  def picked_up
    p = Package.find(params[:id])
    p.picked_up = true
    p.clerk_accepted_id = current_clerk.id
    p.datetime_accepted = Time.now.to_datetime
    if p.save
      flash[:notice] = "package #{p.tracking_number} for #{p.resident_name} was picked up #{p.datetime_received.localtime.ctime}"
      redirect_to packages_path # or to the resident sign-up page if they arent opted in?
    else
      flash[:warning] = "There was an error in updating this package."
      redirect_to package_path p
    end
    redirect_to package_path(p) 
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
