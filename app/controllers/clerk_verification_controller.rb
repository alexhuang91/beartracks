class ClerkVerificationController < ApplicationController
  
  before_filter :load_clerk_using_perishable_token
  
  def show
    if @clerk
      @clerk.verify!
      flash[:notice] = "Thanks for verifying your account.  You may now set your password."
    end
  end
  
  private 
  
  def load_clerk_using_perishable_token
    @clerk = Clerk.find_by_perishable_token(params[:token])
    flash[:error] = "Sorry, we were unable to locate your account. You sure that link is correct?" unless @clerk
  end

end
