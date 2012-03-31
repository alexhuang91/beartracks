class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_clerk_session, :current_clerk
  
  private
    
    def current_clerk_session
      return @current_clerk_session if defined?(@current_clerk_session)
      @current_clerk_session = ClerkSession.find
    end
    
    def current_clerk
      return @current_clerk if defined?(@current_clerk)
      @current_clerk = current_clerk_session && current_clerk_session.clerk
    end
    
end
