class ClerkVerificationController < ApplicationController
  
  before_filter :load_clerk_using_perishable_token
  
  def show
    if @clerk
      @clerk.verify!
      ClerkSession.create! @clerk # log this clerk in 
      flash[:notice] = "Thanks for verifying your account.  You may now set your password."
    end
    redirect_to set_clerk_password_path(:id => @clerk.id)
  end
  
  private 
  
  def load_clerk_using_perishable_token
    #log out anyone if they're logged in
    current_clerk_session.destroy
    
    @clerk = Clerk.find_by_perishable_token(params[:token])
    unless @clerk
      flash[:error] = "Sorry, we were unable to locate your account. You sure that link is correct?"
      redirect_to root_url
    end    
  end

end
