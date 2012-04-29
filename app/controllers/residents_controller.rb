class ResidentsController < ApplicationController

  def new
    @resident = Resident.new
  end

  def show
    # Use find_by_id instead of find so that it will return nil instead of throwing an exception
    @resident = Resident.find_by_id(params[:id])

    # If the resident doesn't exist, go back to the residents page
    if @resident.nil?
      flash[:notice] = "The resident you requested doesn't exist."
      redirect_to residents_path
    end
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

  def index
  end
end
