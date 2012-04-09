require 'spec_helper'

describe PackagesController do
  
  describe "Testing the clerk logged in before filter on index action." do
    
    def do_index 
      get :index
    end
    
    describe "With no clerk logged in." do
      
      before :each do   
        controller.stub(:clerk_logged_in?).and_return(false)
      end
      
      it "should redirect to home page when viewing a package action" do
        do_index
        response.should redirect_to(root_url)
      end
      
      it "should set a flash warning" do
        do_index
        flash[:warning].should_not be_nil
      end
      
      it "should not render the index view" do
        do_index
        response.should_not render_template(:index)
        #page.should
      end

    end
    
    describe "With a clerk logged in." do
      
      before :each do
        controller.stub(:clerk_logged_in?).and_return(true)
      end
      
      it "should render the view" do# need to figure out how to verify since 
        #do_index
        #page.has_content?("All Packages").should be_true
      end
    end
    
    
    
  end
  
end