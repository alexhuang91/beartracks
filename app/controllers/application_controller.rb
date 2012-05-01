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
      {"Unit 1"             => "U1",
       "Unit 2"             => "U2",
       "Unit 3"             => "U3",
       "Unit 4"             => "U4",
       "Clark Kerr"         => "CKC",
       "University Village" => "UV",
       "Smyth Fernwald"     => "SF"}
    end

    def buildings_hash(unit)
      if(unit == "CKC")
        hash = {"CK Building 1"  => "CK1",
                "CK Building 2"  => "CK2",
                "CK Building 3"  => "CK3",
                "CK Building 4"  => "CK4",
                "CK Building 6"  => "CK6",
								"CK Building 5"  => "CK5",
								"CK Building 7"  => "CK7",
								"CK Building 8"  => "CK8",
                "CK Building 9"  => "CK9",
								"CK Building 11" => "CK11",
								"CK Building 12" => "CK12",
								"CK Building 13" => "CK13",
                "CK Building 14" => "CK14",
								"CK Building 15" => "CK15",
								"CK Building 16" => "CK16",
								"CK Building 17" => "CK17",
                "CK Building 18" => "CK18",
								"CK Building 19" => "CK19",
								"CK Building 20" => "CK20"}

      elsif(unit == "U1")
        hash = {"Channing Bowditch" => "CB",
								"Cheney Hall"       => "CH",
								"Christian Hall"    => "CN",
								"Deutsch Hall"      => "DE",
                "Freeborn Hall"     => "FB",
								"Ida Jackson House" => "JH",
								"Putnam Hall"       => "PU",
								"Slottman Hall"     => "SL"}

      elsif(unit == "U2")
        hash = {"Cunningham Hall" => "CU",
								"Davidson Hall"   => "DA",
								"Ehman Hall"      => "EH",
								"Griffiths Hall"  => "GR",
								"Towle Hall"      => "TO",
								"Wada Hall"       => "WA"}

      elsif(unit == "U3")
        hash = {"Beverly Cleary Hall" => "BC",
								"Ida Sproul Hall"     => "IS",
								"Manville Hall"       => "MV",
								"Norton Hall"         => "NO",
								"Priestley Hall"      => "PR",
								"Spens Black Hall"    => "SB"}

      elsif(unit == "U4")
        hash = {"FH Building 1" => "FH1",
								"FH Building 2" => "FH2",
								"FH Building 3" => "FH3",
								"FH Building 4" => "FH4",
								"FH Building 5" => "FH5",
								"FH Building 6" => "FH6",
								"FH Building 7" => "FH7",
								"FH Building 8" => "FH8",
								"FH Building 9" => "FH9",
								"Bowles Hall"   => "BO",
								"Stern Hall"    => "ST"}

      elsif(unit == "UV")
        hash = {"East" => "UVE",
                "West" => "UVW"}

      elsif(unit == "SF")
        hash = {"3002" => "SF3002",
                "3024" => "SF3024",
                "E" => "SFE",
                "F" => "SFF",
                "G" => "SFG",
                "H" => "SFH",
                "J" => "SFJ",
                "K" => "SFK",
                "L" => "SFL"}
      else
        hash = {}
      end
      hash
    end
end
