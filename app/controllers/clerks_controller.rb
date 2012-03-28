class ClerksController < ApplicationController
  
  def new
    @clerk = Clerk.new
  end
  
end
