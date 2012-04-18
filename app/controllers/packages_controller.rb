class PackagesController < ApplicationController
  
  before_filter :clerk_check
  
  def index
    if params[:unit] != session[:unit] or params[:packages] != session[:packages]
      # If the clerk is an admin, store and use the new unit setting.
      # Otherwise, default back to the clerk's unit for the setting.
      if current_clerk.is_admin?
        session[:unit] = params[:unit] || session[:unit]
      else # clerk is not admin
        session[:unit] = current_clerk.unit
      end
      
      # If the new packages setting is not nil, use that. Otherwise, use
      # the session packages setting.
      session[:packages] = params[:packages] || session[:packages]
      
      flash.keep
      redirect_to :unit => session[:unit], :packages => session[:packages] and return
    end
    
    # If either unit or packages setting is not set, default to all
    if not params[:unit] or not params[:packages]
      session[:unit]     = 'all' unless params[:unit]
      session[:packages] = 'all' unless params[:packages]
      flash.keep
      redirect_to :unit => session[:unit], :packages => session[:packages] and return
    end

    # Set up the mappings for the view options
    @units_hash = Hash[units_array.collect { |u| [u,u] }]
    @units_hash['All Units'] = 'all'
    @packages_hash = {'Not picked up' => 'not_picked_up', 
                      'Picked up'     => 'picked_up', 
                      'All Packages'  => 'all'}

    package_value = {'picked_up' => true, 'not_picked_up' => false, 'all' => [true, false]}
    units = params[:unit] == 'all' ? units_array : params[:unit]
    picked = package_value[params[:packages]]
    
    # Set up instance variables for displaying packages
    @packages = Package.where :picked_up => picked, :unit => units
    @table_caption = set_table_caption 
    @clerk = current_clerk
  end

  # set the table caption based on params
  def set_table_caption
    if @packages == []
      package_existence = "No"
    else
      package_existence = "All"
    end

    if params[:packages] == 'all'
      package_status = 'packages'
    elsif params[:packages] == 'picked_up'
      package_status = 'picked up packages'
    else
      package_status = 'not picked up packages'
    end
      
    if params[:unit] == 'all'
      package_unit = '' 
    else
      package_unit = "for #{params[:unit]}"
    end
    
    "#{package_existence} #{package_status} #{package_unit}"
  end
  
  def show
    @package = Package.find params[:id]
    @clerk_received = Clerk.find @package.clerk_id
    if @package.picked_up
      @accepted = true
      @clerk_released = Clerk.find @package.clerk_accepted_id
    end
  end

  def edit
    @new = false
    @package = Package.find params[:id]
  end

  def new
    @new = true
    @clerk_unit = current_clerk.unit
  end

  def create
    p = Package.new params[:package]
    if not p.has_required_fields
      flash[:warning] = "Cannot leave #{p.blank_fields} blank"
      redirect_to new_package_path
    else
      p.datetime_received = Time.now.to_datetime
      p.clerk_id = current_clerk.id
      if p.save
      # TODO Send out an email or text or add to the slip-queue
        flash[:notice] = "Package created successfully."
      else
        flash[:warning] = "There was an error creating this package."
      end
      # Now that the package is saved, redirect to the list of packages if the
      # clerk is done creating them, or another create package form if the
      # clerk wants to create more packages.
      if params[:commit] == "Save Package"
        redirect_to packages_path
      elsif params[:commit] == "Save and Create Another Package"
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
