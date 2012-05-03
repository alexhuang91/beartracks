class MailSender < ActionMailer::Base
  default :from "no-reply@beartracks.herokuapp.com"
  default :host "localhost:3000"
  
  def verification_instructions(clerk)
    @clerk = clerk
    @url = clerk_verification_show_url(clerk.perishable_token, :host => default[:host])
    mail(:to => clerk.email, :subject => "A beartracks account has been created!")
  end
  
end
