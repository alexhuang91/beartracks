#require 'ruby-debug'

class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_clerk_session, :current_clerk, :clerk_logged_in?
  helper_method :current_resident_session, :current_resident
  helper_method :preferences_array, :states_array, :carriers_array, :package_type_array
  helper_method :units_array, :buildings_hash, :all_buildings
  
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

    def preferences_array
      ['Email', 'Mail Slip'] #, 'Text Message']
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

    def units_array
      ["Unit 1",
       "Unit 2",
       "Unit 3",
       "Unit 4",
       "Clark Kerr",
       "Smyth Fernwald",
       "University Village"]
    end

    def buildings_hash
      hash = {"Unit 1" =>
                ["Channing Bowditch",
								 "Cheney Hall",
								 "Christian Hall",
								 "Deutsch Hall",
                 "Freeborn Hall",
								 "Ida Jackson House",
								 "Putnam Hall",
								 "Slottman Hall"],
              "Unit 2" =>
                ["Cunningham Hall",
								 "Davidson Hall",
								 "Ehman Hall",
								 "Griffiths Hall",
								 "Towle Hall",
								 "Wada Hall"],
              "Unit 3" =>
                ["Beverly Cleary Hall",
								 "Ida Sproul Hall",
								 "Manville Hall",
								 "Norton Hall",
								 "Priestley Hall",
								 "Spens Black Hall"],
              "Unit 4" =>
                ["FH Building 1",
								 "FH Building 2",
								 "FH Building 3",
								 "FH Building 4",
								 "FH Building 5",
								 "FH Building 6",
								 "FH Building 7",
								 "FH Building 8",
								 "FH Building 9",
								 "Bowles Hall",
								 "Stern Hall"],
              "Clark Kerr" =>
                ["CK Building 1",
                 "CK Building 2",
                 "CK Building 3",
                 "CK Building 4",
                 "CK Building 6",
								 "CK Building 5",
								 "CK Building 7",
								 "CK Building 8",
                 "CK Building 9",
								 "CK Building 11",
								 "CK Building 12",
								 "CK Building 13",
                 "CK Building 14",
								 "CK Building 15",
								 "CK Building 16",
								 "CK Building 17",
                 "CK Building 18",
								 "CK Building 19",
								 "CK Building 20"],
              "University Village" =>
                ["East",
                 "West"],
              "Smyth Fernwald" =>
                ["3002",
                 "3024",
                 "E",
                 "F",
                 "G",
                 "H",
                 "J",
                 "K",
                 "L"] }
    end

    def all_buildings
      buildings = []
      units = units_array
      units.each do |unit| 
        buildings << ("-- "+unit+" --")
        buildings << buildings_hash[unit]
      end
      buildings.flatten
    end
end
