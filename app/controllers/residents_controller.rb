class ResidentsController < ApplicationController

  def new
    @resident = Resident.new
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
      else
        flash[:error] = "There was a problem. Please try again."
      end
      render :action => :new
    end
  end

end
