class MailSender < ActionMailer::Base
  default :from => "berkeley.beartracks@gmail.com"
  
  def verification_instructions(clerk)
    @clerk = clerk
    @url = clerk_verification_show_url(clerk.perishable_token, :host => "localhost:3000")
    
    # must be last line of method...message is "returned"
    mail(:to => clerk.email, :subject => "A beartracks account has been created!")
  end
  
end
