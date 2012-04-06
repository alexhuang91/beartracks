class ResidentsController < ApplicationController

  def new
    @resident = Resident.new
  end

  def create
    @resident = Resident.new(params[:resident])
    if @resident.save
      ResidentSession.create @resident
      flash[:notice] = "Resident account successfully created."
      redirect_to root_url
    else
      flash[:error] = "There was an error creating this user."
      render :action => :new
    end
  end

end
