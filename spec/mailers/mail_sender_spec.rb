require "spec_helper"

describe MailSender do
  
  before :each do
    @clerk = FactoryGirl.create(:clerk)
  end
  
  it "should create a correct url and make it available to the view" do
    MailSender.verification_instructions(@clerk)
    assigns(:url).should == clerk_verification_show_url(:token => @clerk.perishable_token)
  end
  
end
