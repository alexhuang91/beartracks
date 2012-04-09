require 'spec_helper'

describe PackagesController do
  
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
        
        before :each do
          do_show
        end
        
        it "should redirect to home page" do
          response.should redirect_to(root_url)
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