class HomeController < ApplicationController
  def index
  end

  def signup
    @user = User.new

    if request.post? #checks if the user clicked the "submit" button on the form
      # if user.save #if they have submitted the form attempts to save the user
      #  session[:uid] = user.id #Logs in the new user automatically
       redirect_to :controller => "packages", :action => "show" #Goes to their new calendars page
      #      else #This will happen if one of the validations define in /app/models/user.rb fail for this instance.
#        redirect_to :action => "signup", :notice=>"An error has occurred." #Ask them to sign up again
#      end
    end
  end

  def login
    if request.post? #If the form was submitted
#      if !user.nil? && user.password==params[:password] #Check that this user exists and it's password matches the inputted password
#        session[:uid] = user.id #If so log in the user
        redirect_to :controller => "packages", :action => "show" #And redirect to their calendars
#      else
#        redirect_to :action => "login", :notice=> "Invalid username or password. Please try again." #Otherwise ask them to try again. 
#      end
    end
  end

  def logout
#    session[:uid] = nil #Logs out the user
    flash[:notice] = "You have been successfully logged out"
    redirect_to :index => "home" #redirect to the homepage
  end
end
