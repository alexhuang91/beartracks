require 'spec_helper'

describe Clerk do
  
  before :each do
    @clerk = FactoryGirl.create(:clerk)
  end
  
  it "should have login field" do
    @clerk.should respond_to(:login)
  end
  
  it "should have is_admin field" do
    @clerk.should respond_to(:is_admin?)
  end
  
  it "should have email field" do
    @clerk.should respond_to(:email)
  end
  
  it "should have unit field" do
    @clerk.should respond_to(:unit)
  end
  
end
