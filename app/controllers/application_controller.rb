class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_clerk_session, :current_clerk
  helper_method :current_resident_session, :current_resident
  private
    
    def current_clerk_session
      return @current_clerk_session if defined?(@current_clerk_session)
      @current_clerk_session = ClerkSession.find
    end
    
    def current_clerk
      return @current_clerk if defined?(@current_clerk)
      @current_clerk = current_clerk_session && current_clerk_session.clerk
    end
    
    def current_resident_session
      return @current_resident_session if defined?(@current_resident_session)
      @current_resident_session = ResidentSession.find
    end
    
    def current_resident
      return @current_resident if defined?(@current_resident)
      @current_resident = current_resident_session && current_resident_session.resident
    end

end
