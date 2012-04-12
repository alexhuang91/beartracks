class Clerk < ActiveRecord::Base
  acts_as_authentic do |r|
    r.maintain_sessions = false
  end
  
  attr_protected :is_admin # prevents is admin from being mass assigned
end
