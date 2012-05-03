class MailSender < ActionMailer::Base
  default :from => "berkeley.beartracks@gmail.com"
  
  def verification_instructions(clerk)
    @clerk = clerk
    @url = clerk_verification_show_url(:token => clerk.perishable_token)
    
    # must be last line of method...message is "returned"
    mail(:to => clerk.email, :subject => "A beartracks account has been created for you!")
  end
  
end
