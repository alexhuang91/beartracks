class PackagesController < ApplicationController

  def show
    @package = Package.find params[:id]
    @clerk_received = Clerk.find @package.clerk_received_id
    if @package.picked_up
      @accepted = true
      @clerk_released = Clerk.find @package.clerk_accepted_id
    end
  end

  def index
# need logic to resolve what unit's packages are shown, so as to stay restful
# this can probably be done same as how ratings are remebered in movies_controller
#   if params[:unit] == current_clerk.unit
#     if params[:unit] == 'all'
#       @packages = Package.where :datetime_accepted => nil
#     else
        # By default we want to show all packages. The clerk can filter out picked up ones if he/she desires.
        @packages = Package.all
        #@packages = Package.where :datetime_accepted => nil #, :unit => params[:unit]
#     end
#   else
#     current_clerk.unit = params[:unit]
#     flash.keep
#     redirect_to packages_path
#   end
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
      flash[:error] = "Cannot leave #{p.blank_fields} blank"
      redirect_to new_package_path
    else
      p.datetime_received = Time.now.to_datetime
      # This will let use do "p.clerk" to access a package's clerk 
      p.clerk_id = current_clerk.id
      # TODO clerk_received_id is deprecated. remove once everyone knows about clerk_id
      p[:clerk_received_id] = current_clerk.id
      if p.save
      # TODO Send out an email or text or add to the slip-queue
        flash[:notice] = "package #{p[:tracking_number]} for #{p[:resident_name]} was created at #{p[:datetime_received].localtime.ctime}"
      else
        flash[:error] = "There was an error creating this package."
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
      flash[:notice] = "package #{@package.tracking_number} for #{@package.resident_name} was updated at #{p[:updated_at].ctime}"
      redirect_to package_path @package
    else
      flash[:error] = "There was an error in updating this package."
      redirect_to edit_package_path @package
    end
  end

  def destroy
    # what is there to do here, just remove it from the db? but who gets to do this, admins and/or clerks, and when?
  end

  def picked_up
    p = Package.find(params[:id])
    p.picked_up = true
    p.clerk_accepted_id = current_clerk.id
    p.datetime_accepted = Time.now.to_datetime
    if p.save
      flash[:notice] = "package #{p[:tracking_number]} for #{p[:resident_name]} was picked up at #{p[:datetime_received].localtime.ctime}"
    else
      flash[:error] = "There was an error in updating this package."
    end
    redirect_to package_path(p) 
  end
end
