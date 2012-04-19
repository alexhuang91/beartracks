#require 'ruby-debug'

class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_clerk_session, :current_clerk, :clerk_logged_in?
  helper_method :current_resident_session, :current_resident
  helper_method :units_array, :states_array, :carriers_array, :package_type_array
  
  private
    
    def clerk_logged_in?
      !current_clerk_session.nil?
    end

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

    def html_list(header,list)
      return [header,list].join("<li/>").html_safe
    end

    def units_array
      ['Unit 1', 'Unit 2', 'Unit 3', 'Foothill', 'Bowles', 'Stern',
      'Clark Kerr', 'Manville', 'Ida L. Jackson', 'Channing-Bowditch',
      'Martinez Commons', 'University Village']
    end

    def states_array
      ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA",
      "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD",
      "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
      "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC",
      "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
    end

    def carriers_array
      ["DHL Express", "FedEx", "OnTrac", "UPS", "USPS", "Other"]
    end
    
    def package_type_array
      ["Tube", "Box", "Large box", "Envelope", "Letter", "Other"]
    end
end
