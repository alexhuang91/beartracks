require "spec_helper"

describe MailSender do
  
  before :each do
    @clerk = FactoryGirl.create(:clerk)
  end
  
  it "should create a correct url" do
    mail = MailSender.verification_instructions(@clerk)
    mail.body.include?(clerk_verification_show_url(:token => @clerk.perishable_token, :host => "localhost:3000")).should be_true
  end
  
end
