require 'spec_helper'
#require 'authlogic/test_case'
#include Authlogic::TestCase

describe ClerksController do
  
  #setup :activate_authlogic
    
  describe "create action by non-admin. test before filter" do
    
    before :each do
      @clerk = FactoryGirl.create(:clerk)
      controller.stub(:current_clerk).and_return(@clerk)
    end
    
    it "should not create a new clerk" do
      Clerk.should_not_receive(:new)
      post :create
    end
    
    it "should redirect to packages" do
      post :create
      response.should redirect_to packages_path
    end
    
  end
  
  describe "create action" do
    
    before :each do
      @admin_clerk = FactoryGirl.create(:admin)
      controller.stub(:current_clerk).and_return(@admin_clerk)
    end
    
    describe "happy path. good params sent." do
      
      def post_good_create
        post :create, :clerk => @clerk_good_params
      end
      
      before :each do
        @clerk_good_params = {"login" => "ringostarr", 
                         "first_name" => "Ringo",
                         "last_name" => "Starr",
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
      
      it "should not log the new clerk in" do
        ClerkSession.should_not_receive(:create!).with(@fake_clerk)
        post_good_create
      end
      
      it "should set a flash for success" do
        post_good_create
        flash[:notice].should_not be_nil
      end
      
      it "should redirect to the clerks page" do
        post_good_create
        response.should redirect_to(clerks_path)
      end
      
    end
    
    describe "sad path. bad params sent" do
      
      def post_bad_create
        post :create, :clerk => @clerk_bad_params
      end
      
      before :each do
        @clerk_bad_params = {:login => "ringostarr", 
                        :first_name => "Ringo",
                        :last_name => "Starr",
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
  
  describe "new action. and admin before filtering." do
    
    describe "admin clerk logged in." do
      
      before :each do
        @clerk = FactoryGirl.create(:admin)
        controller.stub(:current_clerk).and_return(@clerk)
        get :new
      end
      
      it "should render the new view" do
        response.should render_template(:new)
      end
    
    end
    
    describe "non-admin clerk logged in" do
      
      before :each do
        @clerk = FactoryGirl.create(:clerk)
        controller.stub(:current_clerk).and_return(@clerk)
        get :new
      end
      
      it "should not render the new view" do
        response.should_not render_template(:new)
      end
      
      it "should redirect to the clerks home path" do
        response.should redirect_to packages_path
      end
      
    end
    
  end
  
  describe "edit action." do
    
    describe "get w/ correct id." do
    
      before :each do
        @clerk = FactoryGirl.create(:clerk)
        controller.stub(:current_clerk).and_return(@clerk)
        get :edit, :id => @clerk.id
      end

      it "should render edit view" do
        response.should render_template(:edit)
      end

      it "should set the correct clerk and make it available to the view" do
        assigns(:clerk).should == @clerk
      end
      
    end
    
    describe "get other id. BEFORE FILTER TEST" do
      
      before :each do
        @clerk1 = FactoryGirl.create(:clerk)
        @clerk2 = FactoryGirl.create(:clerk)
        controller.stub(:current_clerk).and_return(@clerk1)
        get :edit, :id => @clerk2.id
      end
      
      it "should not render edit view" do
        response.should_not render_template(:edit)
      end
      
      it "should redirect to home view" do
        response.should redirect_to clerk_home_path
      end
      
      it "should set a flash warning" do
        flash[:warning].should_not be_nil
      end
      
    end
    
  end
  
  describe "update action. change login. Happy path. good form attributes." do
    
    before :each do
      @clerk = FactoryGirl.create(:clerk)
      controller.stub(:current_clerk).and_return(@clerk)
      put :update, :id => @clerk.id, :clerk => {:login => "Ringo", :password => ""} 
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
      controller.stub(:current_clerk).and_return(@clerk)
      put :update, :id => @clerk.id, :clerk => {:email => "email"}
    end
    
    it "should render the new view" do
      response.should redirect_to edit_clerk_path(@clerk)
    end
    
    it "should set a flash error" do
      flash[:error].should_not be_nil
    end
    
  end
  
  describe "update action. test before filter" do
    
    def update_other_id
      put :update, :id => @clerk2.id, :clerk => {:login => "dude"}
    end
    
    before :each do
      @clerk1 = FactoryGirl.create(:clerk)
      @clerk2 = FactoryGirl.create(:clerk)
      controller.stub(:current_clerk).and_return(@clerk1)
    end
    
    it "should not update attributes" do
      @clerk2.should_not_receive(:update_attributes)
      update_other_id
    end
    
    it "should redirect" do
      update_other_id
      response.should be_redirect
    end
    
  end
  
  describe "toggle_admin access." do
    
    before :each do
      @admin_clerk = FactoryGirl.create(:admin)
      @non_clerk = FactoryGirl.create(:clerk)
      controller.stub(:current_clerk).and_return(@admin_clerk)
      Clerk.stub(:find).and_return(@non_clerk)
    end
    
    def do_toggle
      get :toggle_admin_access, :id => @non_clerk.id
    end
    
    it "should determine the admin status of the clerk id passed in." do
      @non_clerk.should_receive(:is_admin?)
      do_toggle
    end
    
    it "should set the clerk admin to true" do
      @non_clerk.should_receive(:is_admin=).with(true)
      do_toggle
    end
    
    it "should save the modified record" do
      @non_clerk.should_receive(:save)
      do_toggle
    end
    
    it "should redirect to clerks page" do
      do_toggle
      response.should redirect_to clerks_path
    end
    
    it "the old non-admin should now be an admin clerk in the db"
    
  end

end
