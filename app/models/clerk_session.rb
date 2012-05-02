class ClerkSession < Authlogic::Session::Base

  validate :check_if_verified
  
  private
  
  def check_if_verified
    errors.add(:base, "Your account has not yet been verified") unless attempted_record and attempted_record.verified
  end

end