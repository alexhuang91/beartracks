class PackagesController < ApplicationController
  
  before_filter :clerk_check
  
  def index
    params_and_session_dont_match = params[:unit] != session[:unit] || params[:packages] != session[:packages]
    a_param_is_nil = !params[:unit] || !params[:packages]
    if a_param_is_nil or params_and_session_dont_match
      # If the clerk is an admin, store and use the new unit setting (or default to 'all').
      # Otherwise, enforce viewing only the clerk's unit for the setting.
      if current_clerk.is_admin?
        session[:unit] = params[:unit] || session[:unit] || 'all'
      else # clerk is not admin
        session[:unit] = current_clerk.unit
      end
      
      # If the new packages setting is not nil, use that. Otherwise, use
      # the session packages setting.
      session[:packages] = params[:packages] || session[:packages] || 'all'
      
      flash.keep
      if params[:commit] == 'Search'
        redirect_to :unit => session[:unit], :packages => session[:packages],
        :search_option => params[:search_option], :search_string => params[:search_string],
        :commit => 'Search' and return
      else
        redirect_to :unit => session[:unit], :packages => session[:packages] and return
      end
    end

    # Set up the mappings for the view options
    @units_hash = Hash[units_array.collect { |unit| [unit,unit] }]
    @units_hash['All Units'] = 'all'
    @packages_hash = {'Not picked up' => 'not_picked_up', 
                      'Picked up'     => 'picked_up', 
                      'All packages'  => 'all'}
    @search_options = ['ID', 'Tracking Number', 'Room', 'Building', 'Carrier', 'Resident Name', 'Package Type']
    @search_options = Hash[@search_options.collect{ |option| [option, option.downcase.gsub(/\s/, '_')] }]

    package_value = {'picked_up' => true, 'not_picked_up' => false, 'all' => [true, false]}
    units = params[:unit] == 'all' ? units_array : params[:unit]
    picked = package_value[params[:packages]]
    
    # Select the packages to display
    if params[:commit] == 'Search' and @search_options.values.include?(params[:search_option])
      @packages = Package.where(:picked_up => picked, :unit => units, params[:search_option] => params[:search_string]).page params[:page]
      @option = params[:search_option]
      @s_string = params[:search_string]
      @searching = true # instance variable used when setting the table caption
    else
      @packages = Package.where(:picked_up => picked, :unit => units).page params[:page]
    end

    # Set up instance variables for displaying packages
    @viewing_all = params[:packages] == "all"
    @table_caption = set_table_caption 
    @clerk = current_clerk
    @unit_selection = params[:unit]
    @packages_selection = params[:packages]
  end

  # set the table caption based on params
  def set_table_caption
    return "Search results" if @searching
    
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
    @package = Package.find_by_id(params[:id])
    @clerk = current_clerk
    
    # If the package can't be found, go back to the packages page
    if @package.nil?
      flash[:notice] = "Package #{params[:id]} doesn't exist."
      redirect_to packages_path
    else
      if @package.picked_up
        @accepted = true
        @clerk_released = Clerk.find @package.clerk_accepted_id
      end
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
      flash[:warning] = "Cannot leave #{p.blank_fields} blank."
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
    
    # Try to update the package and rescue the exception if one is thrown
    begin
      params[:package][:updated_at] = Time.now.to_datetime
      updated = @package.update_attributes(params[:package])
    rescue
      flash[:warning] = "Could not update package due to connection or remote service error."
      redirect_to edit_package_path
    end
   
    # Check to see if all the required fields are there and update if so
    if not @package.has_required_fields
      flash[:warning] = "Cannot leave #{@package.blank_fields} blank."
      redirect_to edit_package_path
    else
      if updated
        flash[:notice] = "Package was updated successfully."
        redirect_to package_path @package
      else
        flash[:warning] = "There was an error in updating this package."
        redirect_to edit_package_path
      end
    end
  end

  def destroy
    # Only admins can delete packages
    if current_clerk.is_admin?
      @package = Package.find params[:id]
      @package.destroy
      flash[:notice] = "Package was deleted successfully."
      redirect_to packages_path
    else
      flash[:warning] = "Only admins can delete packages."
      redirect_to package_path @package
    end
  end

  # Toggles the pickup status of a package
  def toggle_pickup
    p = Package.find(params[:id])
    
    if p.picked_up 
      p.picked_up = false
      p.clerk_accepted_id = nil
      p.datetime_accepted = nil
      
      if p.save
        flash[:notice] = "Package was marked as not picked up."
        redirect_to packages_path
      else
        flash[:warning] = "There was an error in marking this package as not picked up."
        redirect_to package_path p
      end
    else
      p.picked_up = true
      p.clerk_accepted_id = current_clerk.id
      p.datetime_accepted = Time.now.to_datetime
      if p.save
        flash[:notice] = "Package was marked as picked up."
        redirect_to packages_path # or to the resident sign-up page if they arent opted in?
      else
        flash[:warning] = "There was an error in marking this package as picked up."
        redirect_to package_path p
      end
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
