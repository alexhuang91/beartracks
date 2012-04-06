require 'spec_helper'

describe ClerkSessionsController do
  
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
  
  def do_create
    post :create
  end
  
  before :each do
    @fake_session = mock('ClerkSession')
  end
  
  describe "creating a new clerk session (logging in)" do
    
    before :each do
      @fake_session.stub(:save).and_return(true)
      ClerkSession.stub(:new).and_return(@fake_session)
    end
    
    it "should create a new ClerkSession object" do
      ClerkSession.should_receive(:new)
      do_create
    end
    
    it "should save this new ClerkSession object" do
      @fake_session.should_receive(:save)
      do_create
    end
    
    describe "Upon successful saving of session object" do
      before :each do
        @fake_session.stub(:save).and_return(true)
      end
      
      it "should redirect to root page" do
        do_create
        response.should redirect_to(packages_path)
      end
      
      it "should set a flash notice" do
        do_create
        flash[:notice].should_not be_nil
      end
      
      it "should not set a flash warning" do
        do_create
        flash[:warning].should be_nil
      end
      
    end
    
    describe "When a ClerkSession is not validated" do
      before :each do
        @fake_session.stub(:save).and_return(false)
      end
      
      it "should not post to clerk login page" do 
      end
      
      it "should set a flash warning" do
        do_create
        flash[:warning].should_not be_nil
      end
      
      it "should not set a flash notice" do
        do_create
        flash[:notice].should be_nil
      end
            
    end
    
    
    
  end

  describe "Logging out of a clerk session." do 
    
    def do_logout
      get :destroy
    end
    
    describe "When a clerk is currently logged in." do
      before :each do
        controller.stub(:current_clerk_session).and_return(@fake_session)
        @fake_session.stub(:nil?).and_return(false)
        @fake_session.stub(:destroy)
      end

      it "should destroy the current session" do
        @fake_session.should_receive(:destroy)
        do_logout
      end
      
      it "should set a flash notice" do
        do_logout
        flash[:notice].should_not be_nil
      end
      
      it "should redirect to root page" do
        do_logout
        response.should redirect_to(root_path)
      end
      
    end
 
  end
  
  describe "Prevent a User from logging in as a Clerk when a Resident is already logged in." do
    
    before :each do
      # log in a resident
      @resident = Resident.create!(:login => "johnlennon", :email => "mail@mail.com", :password => "pass", :password_confirmation => "pass")
      @sesh = ResidentSession.create!(:login => "johnlennon", :password => "pass", :remember_me => true)
    end
    
    after :each do
      @sesh.destroy
      @resident.destroy
    end
    
    it "should not create a clerk session when a login is attempted" 
    
    it "should not allow viewing of clerk login page" 
    
    it "should redirect to the home page" 
    
  end
  
  
end
