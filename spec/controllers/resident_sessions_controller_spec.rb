require 'spec_helper'

describe ResidentSessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end
  
  describe "Prevent a User from logging in as a Resident when a Clerk is already logged in." do
    
    def do_create
      post :create
    end
    
    before :each do
      # log in a clerk
      @clerk = Clerk.create!(:login => "johnlennon", :password => "pass", :password_confirmation => "pass")
      @sesh = ClerkSession.create!(:login => "johnlennon", :password => "pass", :remember_me => true)
    end
    
    after :each do
      @sesh.destroy
      @clerk.destroy
    end
    
    it "should not create a resident session when a login is attempted" 
    it "should not allow viewing of clerk login page"
    it "should redirect to the home page"
    
  end

end
