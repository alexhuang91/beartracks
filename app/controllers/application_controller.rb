#require 'ruby-debug'

class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_clerk_session, :current_clerk, :clerk_logged_in?
  helper_method :current_resident_session, :current_resident
  helper_method :preferences_array, :states_array, :carriers_array, :package_type_array
  helper_method :units_hash, :buildings_hash
  
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
      ['Mail Slip', 'Email'] #, 'Text Message']
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

    def units_hash
      {"Unit 1"             => "Unit 1",
       "Unit 2"             => "Unit 2",
       "Unit 3"             => "Unit 3",
       "Unit 4"             => "Unit 4",
       "Clark Kerr"         => "Clark Kerr",
       "University Village" => "University Village",
       "Smyth Fernwald"     => "Smyth Fernwald"}
    end

    def buildings_hash(unit)
      if(unit == "CKC")
        hash = {"Building 1"  => "Building 1",
                "Building 2"  => "Building 2",
                "Building 3"  => "Building 3",
                "Building 4"  => "Building 4",
                "Building 6"  => "Building 6",
								"Building 5"  => "Building 5",
								"Building 7"  => "Building 7",
								"Building 8"  => "Building 8",
                "Building 9"  => "Building 9",
								"Building 11" => "Building 11",
								"Building 12" => "Building 12",
								"Building 13" => "Building 13",
                "Building 14" => "Building 14",
								"Building 15" => "Building 15",
								"Building 16" => "Building 16",
								"Building 17" => "Building 17",
                "Building 18" => "Building 18",
								"Building 19" => "Building 19",
								"Building 20" => "Building 20"}

      elsif(unit == "U1")
        hash = {"Channing Bowditch" => "Channing Bowditch",
								"Cheney Hall"       => "Cheney Hall",
								"Christian Hall"    => "Christian Hall",
								"Deutsch Hall"      => "Deutsch Hall",
                "Freeborn Hall"     => "Freeborn Hall",
								"Ida Jackson House" => "Ida Jackson House",
								"Putnam Hall"       => "Putnam Hall",
								"Slottman Hall"     => "Slottman Hall"}

      elsif(unit == "U2")
        hash = {"Cunningham Hall" => "Cunningham Hall",
								"Davidson Hall"   => "Davidson Hall",
								"Ehman Hall"      => "Ehman Hall",
								"Griffiths Hall"  => "Griffiths Hall",
								"Towle Hall"      => "Towle Hall",
								"Wada Hall"       => "Wada Hall"}

      elsif(unit == "U3")
        hash = {"Beverly Cleary Hall" => "Beverly Cleary Hall",
								"Ida Sproul Hall"     => "Ida Sproul Hall",
								"Manville Hall"       => "Manville Hall",
								"Norton Hall"         => "Norton Hall",
								"Priestley Hall"      => "Priestley Hall",
								"Spens Black Hall"    => "Spens Black Hall"}

      elsif(unit == "U4")
        hash = {"FH Building 1" => "FH Building 1",
								"FH Building 2" => "FH Building 2",
								"FH Building 3" => "FH Building 3",
								"FH Building 4" => "FH Building 4",
								"FH Building 5" => "FH Building 5",
								"FH Building 6" => "FH Building 6",
								"FH Building 7" => "FH Building 7",
								"FH Building 8" => "FH Building 8",
								"FH Building 9" => "FH Building 9",
								"Bowles Hall"   => "Bowles Hall",
								"Stern Hall"    => "Stern Hall"}

      elsif(unit == "UV")
        hash = {"East" => "East",
                "West" => "West"}

      elsif(unit == "SF")
        hash = {"3002" => "3002",
                "3024" => "3024",
                "E" => "E",
                "F" => "F",
                "G" => "G",
                "H" => "H",
                "J" => "J",
                "K" => "K",
                "L" => "L"}
      else
        hash = {}
      end
      hash
    end
end
