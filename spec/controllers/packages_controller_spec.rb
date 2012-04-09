require 'spec_helper'

describe PackagesController do

 describe "Testing all the package controller methods" do

  def do_index 
    get :index, :packages => 'all', :unit => 'all'
  end

  before :each do
    controller.stub(:clerk_logged_in?).and_return(true)
    @fakePackage = mock('Package')
    @fakePackage.stub(:id).and_return(2343)
    Package.stub(:find).with("2343").and_return(@fakePackage)
    @fakePackage.stub(:picked_up=)
    @fakeClerk = mock('Clerk', :id => 123)
    Clerk.stub(:find).with(123).and_return(@fakeClerk)
    Package.stub(:new).and_return(@fakePackage)
    controller.stub(:current_clerk).and_return(@fakeClerk)
    @fakePackage.stub(:clerk_received_id=)
    @fakePackage.stub(:clerk_id=)
    @fakePackage.stub(:datetime_received=)
    @fakePackage.stub(:clerk_accepted_id=)
    @fakePackage.stub(:datetime_accepted=)
    @fakePackage.stub(:save).and_return(true)
    @fakePackage.stub(:tracking_number).and_return(123)
    @fakePackage.stub(:resident_name).and_return("a")
    @fakePackage.stub(:datetime_received).and_return(Time.now)
    @fakePackage.stub(:update_attributes).and_return(true)
    @fakePackage.stub(:updated_at).and_return(Time.now)
    @fakePackage.stub(:clerk_received_id).and_return(123)
    @fakePackage.stub(:picked_up).and_return(false)
    @fakePackage.stub(:blank_fields).and_return("Asdf")
    end
  
  it "should render the new package view" do
    get :new
    response.should be_success
    end

  it "should redirect to the index view" do
    controller.stub(:package_path).with(@fakePackage).and_return("/packages/2343")
    put :update, :id => @fakePackage.id, :package => {}
    response.should redirect_to(:action => :show)
    end

  it "should display the details of a package" do
   get :show, :id => @fakePackage.id
   response.should be_success
   end

  it "should display the view for the picked up method" do
    put :picked_up, :id => @fakePackage.id
    response.should redirect_to(:action => :index)
  end

  it "should display a notice to the clerk when a package is accepted" do
    put :picked_up, :id => @fakePackage.id
    flash[:notice].should_not be_nil
    end

  it "should render the landing page view" do
    do_index
    response.should redirect_to(:action => :index, :packages => "all", :unit => "all")
    end

  it "should render the package details view" do
    get :edit, :id => @fakePackage.id
    response.should be_success
    end

  it "should display a warning for the unfilled necessary entries" do
    @fakePackage.stub(:has_required_fields).and_return(false)
    get :create
    flash[:warning].should_not be_nil
    end

  it "should display a notice saying that a package was created" do
    @fakePackage.stub(:has_required_fields).and_return(true)
    get :create, :package => {}
    flash[:notice].should_not be_nil
    end
  end
  describe "Testing the clerk logged in before filter on index action." do
    
    def do_index 
      get :index, :packages => 'all', :unit => 'all'
    end
    
    def do_show
      get :show, :id => 1
    end
    
    describe "With no clerk logged in." do
      
      before :each do   
        controller.stub(:clerk_logged_in?).and_return(false)
      end
      
      describe "index action." do
        
        it "should redirect to home page when viewing a package index action" do
          do_index
          response.should redirect_to(root_url)
        end

        it "should set a flash warning" do
          do_index
          flash[:warning].should_not be_nil
        end

        it "should not render the index view" do
          do_index
          response.should_not redirect_to(:action => :index, :packages => "all", :unit => "all")
        end
      end
      
      describe "show action." do
        
        it "should redirect to home page" do
          do_show
          response.should redirect_to(root_url)
        end
        
      end
      
      describe "edit action." do
        it "should redirect to home page" do
          get :edit, :id => 1
          response.should redirect_to(root_url)
        end
      end
      
      describe "new action." do
        it "should redirect to home page" do
          get :new
          response.should redirect_to root_url
        end
      end
      
      describe "create action." do
        it "should redirect to home page" do
          post :create
          response.should redirect_to root_url
        end
      end
      
      describe "update action." do
        it "should redirect to home page" do
          get :update, :id => 1
          response.should redirect_to root_url
        end
      end
      
      describe "destroy action." do
        it "should redirect to home page" do
          get :destroy, :id => 1
          response.should redirect_to root_url
        end
      end
      
    end
    
    describe "With a clerk logged in." do
      
      before :each do
        controller.stub(:clerk_logged_in?).and_return(true)
      end
      
      describe "index action" do
        it "should render the view" do# need to figure out how to verify since 
          do_index
          response.should redirect_to(:action => :index, :packages => "all", :unit => "all")
        end

        it "should not set a flash warning" do
          do_index
          flash[:warning].should be_nil 
        end

        it "should not redirect to root" do
          do_index
          response.should_not redirect_to(root_url)
        end
      
      end
      
    end
    
    
    
  end
  
end
