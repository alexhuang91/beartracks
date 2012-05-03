class PackagesController < ApplicationController
  
  before_filter :clerk_check
  
  def index
    params_and_session_dont_match = params[:unit] != session[:unit] || params[:packages] != session[:packages]
    a_param_is_nil = !params[:unit] || !params[:packages]
    if (params[:sort] == nil)
        ordering = "datetime_received DESC"
    else
        ordering = params[:sort]
    end
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
        redirect_to :unit => session[:unit], :packages => session[:packages], :sort => params[:sort],
        :search_option => params[:search_option], :search_text => params[:search_text], :search_select => params[:search_select],
        :commit => 'Search' and return
      else
        redirect_to :unit => session[:unit], :packages => session[:packages], :sort => params[:sort] and return
      end
    end

    # Set up the mappings for the view options
    @units_hash = Hash[units_array.collect{ |u| [u,u] }]
    @units_hash['All Units'] = 'all'
    @packages_hash = {'Not picked up' => 'not_picked_up', 
                      'Picked up'     => 'picked_up', 
                      'All packages'  => 'all'}
    @search_options = ['ID', 'Tracking Number', 'Room', 'Building', 'Carrier', 'Resident First Name', 'Resident Last Name', 'Resident Full Name', 'Package Type']
    @search_options = Hash[@search_options.collect{ |option| [option, option.downcase.gsub(/\s/, '_')] }]

    package_value = {'picked_up' => true, 'not_picked_up' => false, 'all' => [true, false]}
    units = params[:unit] == 'all' ? units_array : params[:unit]
    picked = package_value[params[:packages]]
    
    # Select the packages to display
    if params[:commit] == 'Search' and @search_options.values.include?(params[:search_option])
      params[:search_option].downcase == "building" ? search_string = params[:search_select] : search_string = params[:search_text]
      if (params[:search_option] == "resident_full_name")
        temp = search_string.split(" ")
        first = temp[0]
        if (temp.length > 1)
          last = temp[1..temp.length - 1].join(" ")
        else
          last = ""
          end
        @packages = Package.where(:picked_up => picked, :unit => units, :resident_first_name => first, :resident_last_name => last).order(ordering).page params[:page]
      else
        @packages = Package.where(:picked_up => picked, :unit => units, params[:search_option] => search_string).order(ordering).page params[:page]
        end
      @option = params[:search_option]
      @s_string = params[:search_string]
      @searching = true # instance variable used when setting the table caption
    else
      @packages = Package.where(:picked_up => picked, :unit => units).order(ordering).page params[:page]
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
    # Use find_by_id instead of find so that it will return nil instead of throwing an exception
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
        #Associate the package with the appropriate resident
        first_collection = Resident.where( :unit => params[:package][:unit], :room => params[:package][:room], :building => params[:package][:building])
        second_collection =  first_collection.find_all {|resid| ((resid.first_name == params[:package][:resident_first_name]) || resid.nickname == params[:package][:resident_first_name]) && (resid.last_name == params[:package][:resident_last_name])}
        if (second_collection[0])
          p.resident = second_collection[0]
          p.save
	  flash[:notice] = "Package created, #{p.resident.first_name} #{p.resident.last_name} was successfully notified"
          print p.resident.first_name
        end
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

  def package_slips
  # most of the info on how to set it up came from here: http://stackoverflow.com/questions/8658302/
  # how to make the pdf came mostly from here: http://prawn.majesticseacreature.com/manual.pdf
    if params[:format].blank?
      redirect_to :format => 'pdf' and return
    end

    packages = Package.all # should be Package.where(resident_id: nil, notified: false) or something

    pdf = Prawn::Document.new( margin: 36, top_margin: 72, bottom_margin: 72 )

    pdf.define_grid( rows: 3, columns: 2, gutter: 36 )
    packages.each_with_index do |package, i|
      if i%6 == 0 && i != 0
        pdf.start_new_page
      end
      pdf.grid(i%6/2, i%2).bounding_box do # draw the boarderline, now make a smaller box to go inside
        pdf.stroke_bounds
        top    = pdf.bounds.top
        left   = pdf.bounds.left
        right  = pdf.bounds.right
        bottom = pdf.bounds.bottom

        pdf.bounding_box( [left+3, top-3], width: right-left-6, height: top-bottom-6 ) do
          pdf.text package.unit
          pdf.text package.building + ", room " + package.room
          pdf.text "Resident: " + package.resident_first_name + " " + package.resident_last_name
          pdf.text "Package ID = #{package.id}\n\n"
          pdf.text "You just received a package! Pick it up at\n#{package.unit}'s mailroom.\n\n"
          pdf.text "Are you sick of package slips? Want to move into the 21st century? Try beartracks.\n\n\n"
          pdf.text "beartracks.heroku.com"
        end
      end
    end

    send_data pdf.render, type: "application/pdf", disposition: "inline"#, filename: "pslips_"+Time.now.to_date.to_s+".pdf" somehow
  end
  
  protected
  
  def clerk_check
    if not clerk_logged_in?
      flash[:warning] = "You must be logged in as a clerk to access that."
      redirect_to root_url
      return false
    end
    return true
  end

end
