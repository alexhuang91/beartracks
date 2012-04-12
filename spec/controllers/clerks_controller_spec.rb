require 'spec_helper'

describe ClerksController do

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
      response.should render_template(:edit)
    end
    
  end

end
