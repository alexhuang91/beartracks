class PackagesController < ApplicationController

def show
  @package = Package.find params[:id]
end

def index
# need logic to resolve what unit's packages are shown, so as to stay restful
# this can probably be done same as how ratings are remebered in movies_controller
  @packages = Package.all
# @packages = Package.find_all_by_unit[params[:unit]]
end

def edit
  @package = Package.find params[:id]
end

def new

end

def create
  p = params[:package]
  p[:datetime_received] = Time.now #TODO deal with timezone issue
  p[:clerk_received_id] = current_clerk.id
  if Package.create(p)
    # todo Send out an email or text or add to the slip-queue
    flash[:notice] = "package #{p[:tracking_number]} for #{p[:resident_name]} was created at #{p[:datetime_received]}"
  else
    flash[:error] = "There was an error creating this package."
  end
# consider having two paths, one redirects to packages_path, the other to another new package
  redirect_to packages_path
end

def update
  @package = Package.find params[:id]
  p = params[:package]
  if @package.update_attributes(p)
    flash[:notice] = "package #{p[:tracking_number]} for #{p[:resident_name]} was updated at #{p[:datetime_received]}"
    redirect_to package_path params[:id]
  else
    flash[:error] = "There was an error in updating this package."
    redirect_to edit_package_path params[:id]
  end
end

def destroy

end

def picked_up
  p = Package.find(params[:id])
  p.clerk_accepted_id = current_clerk.id
  p.datetime_accepted = Time.now
  if p.save
    flash[:notice] = "package #{p[:tracking_number]} for #{p[:resident_name]} was picked up at #{p[:datetime_received].time}"
  else
    flash[:error] = "There was an error in updating this package."
  end
  redirect_to packages_path
end

end
