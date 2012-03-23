class PackagesController < ApplicationController

def show

end

def index

end

def edit

end

def new

end

def create
  @package = Package.create!(params[:package])
  @package.datetime_created = Time.now
  #@package.clerk_received_id = session[:clerk].id #or something
# todo Send out an email or text or add to the slip-queue
  flash[:notice] = "package #{@package.tracking_number} for #{@package.resident_name} was successfully created at #{@package.datetime_received}"
  redirect_to packages_path
end

def update

end

def destroy

end

end
