class ResidentsController < ApplicationController

  def new
    @resident = Resident.new
  end

  def show
    @resident = Resident.find(params[:id])
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
      flash[:notice] = "#{@resident.login} was successfully updated."
      redirect_to resident_path(@resident)
    end
  end

  def index
  end
end
