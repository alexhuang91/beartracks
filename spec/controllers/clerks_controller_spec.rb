require 'spec_helper'
#require 'authlogic/test_case'
#include Authlogic::TestCase

describe ClerksController do
  
  #setup :activate_authlogic
    
  describe "create action" do
    
    describe "happy path. good params sent." do
      
      def post_good_create
        post :create, :clerk => @clerk_good_params
      end
      
      before :each do
        @clerk_good_params = {"login" => "ringostarr", 
                         "password" => "pass",
                         "password_confirmation" => "pass", 
                         "email" => "ringo@beatles.com", 
                         "unit" => "Unit 1"}
        @fake_clerk = Clerk.new(@clerk_good_params)
        Clerk.stub(:new).and_return(@fake_clerk)
      end
      
      it "should create a clerk" do
        Clerk.should_receive(:new).with(@clerk_good_params)
        post_good_create
      end
      
      it "should make the clerk available to the view" do
        post_good_create
        assigns(:clerk).should == @fake_clerk
      end
      
      it "should log the new clerk in" do
        ClerkSession.should_receive(:create!).with(@fake_clerk)
        post_good_create
      end
      
      it "should set a flash for success" do
        post_good_create
        flash[:notice].should_not be_nil
      end
      
      it "should redirect to the clerk home page" do
        post_good_create
        response.should redirect_to(clerk_home_path)
      end
      
    end
    
    describe "sad path. bad params sent" do
      
      def post_bad_create
        post :create, :clerk => @clerk_bad_params
      end
      
      before :each do
        @clerk_bad_params = {:login => "ringostarr", 
                        :password => "pas",
                        :password_confirmation => "pas", 
                        :email => "ringo@beatles.com", 
                        :unit => "Unit 1"}
        @fake_clerk = Clerk.new(@clerk_bad_params)
        Clerk.stub(:new).and_return(@fake_clerk)
      end
      
      it "should not create a clerk session" do
        ClerkSession.should_not_receive(:create!)
        post_bad_create
      end
      
      it "should redirect to the new clerk page" do
        post_bad_create
        response.should redirect_to new_clerk_path
      end
      
      it "should set a flash error" do
        post_bad_create
        flash[:error].should_not be_nil
      end
      
      it "should grab the errors from the clerk obj" do
        post_bad_create
        flash[:error].include?("Password is too short").should be_true
      end
      
    end
    
  end
  
  describe "edit action." do
    
    before :each do
      @clerk = FactoryGirl.create(:clerk)
      get :edit, :id => @clerk.id
    end
    
    it "should render edit view" do
      response.should render_template(:edit)
    end
    
    it "should set the correct clerk and make it available to the view" do
      assigns(:clerk).should == @clerk
    end
    
  end
  
  describe "update action. change login. Happy path. good form attributes." do
    
    before :each do
      @clerk = FactoryGirl.create(:clerk)
      put :update, :id => @clerk.id, :clerk => {:login => "Ringo"} 
    end
    
    it "should render the view for this clerk" do
      response.should redirect_to clerk_path(@clerk)
    end
    
    it "should set a flash" do
      flash[:notice].should_not be_nil
    end
    
    it "should make correct clerk accessible to the view" do
      assigns(:clerk).should == @clerk
    end
    
  end
  
  describe "update action. Sad Path. Bad form values." do
    
    before :each do
      @clerk = FactoryGirl.create(:clerk)
      put :update, :id => @clerk.id, :clerk => {:email => "email"}
    end
    
    it "should render the new view" do
      response.should redirect_to edit_clerk_path(@clerk)
    end
    
    it "should set a flash error" do
      flash[:error].should_not be_nil
    end
    
  end

end
