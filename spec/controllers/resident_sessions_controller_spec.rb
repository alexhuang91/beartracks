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
  
  describe "Prevent a User from logging in as a resident when a clerk is already logged in." do
    
    def do_create
      post :create
    end
    
    before :each do
      @fake_session = mock('ClerkSession')
      controller.stub(:current_clerk_session).and_return(@fake_session)
      @fake_session.stub(:nil?).and_return(false)
    end
    
    it "should not create a resident session when a login post request is attempted" do
      ResidentSession.should_not_receive(:new)
      do_create
    end
    
    it "should not allow viewing of resident login page" do
      get :new # go to clerk/login
      response.should_not render_template("new")
    end
    
    it "should redirect to the clerk home page when trying to view resident login page" do
      get :new
      response.should redirect_to(clerk_home_path)
    end
    
    it "should redirect to the clerk home page when trying to post a resident login request" do
      do_create
      response.should redirect_to(clerk_home_path)
    end
    
  end
end
