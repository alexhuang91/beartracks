class ResidentsController < ApplicationController
  before_filter :check_id_access, :only => [:edit, :update, :show]

  # NEW RESIDENT
  def new
    @resident = Resident.new
  end

  # 
  def show
    # Use find_by_id instead of find so that it will return nil instead of throwing an exception
    @resident = Resident.find_by_id(params[:id])

    # If the resident doesn't exist, go back to the residents page
  end

  def create
    @resident = Resident.new(params[:resident])
    if @resident.save
      ResidentSession.create! @resident
      flash[:notice] = "Resident account successfully created. "
      redirect_to root_url
    else
      if @resident.errors.any?
        flash[:error] = html_list("Please fix the following errors:\n", @resident.errors.full_messages)
      end
      redirect_to new_resident_path
    end
  end

  def edit
    @resident = Resident.find(params[:id])
  end

  # UPDATES RESIDENT SETTINGS
  def update
    @resident = Resident.find(params[:id])
    @resident.update_attributes(params[:resident])
    if @resident.errors.any?
      flash[:error] = html_list("Please fix the following errors:\n", @resident.errors.full_messages)
      redirect_to edit_resident_path(@resident)
    else
      flash[:notice] = "Profile was successfully updated."
      redirect_to resident_path(@resident)
    end
  end

  # INDEX PAGE
  def index
  end

  def check_id_access
    if current_resident.nil?
      flash[:warning] = "Sorry, you don't have access to that!"
      redirect_to root_path
      return false
    end
    unless params[:id].to_i == current_resident.id
      flash[:warning] = "Sorry, you don't have access to that!"
      redirect_to residents_path
      return false
    end
    return true
  end

end
