class Clerk < ActiveRecord::Base
  acts_as_authentic do |r|
    r.maintain_sessions = false
  end
  
  attr_protected :is_admin # prevents is admin from being mass assigned
  
  validates_presence_of :first_name, :message => "Must specify your First Name"
  validates_presence_of :last_name, :message => "Must specity your Last Name"
  
  def verify!
    self.verified = true
    self.save!
  end
  
end
