class Resident < ActiveRecord::Base
  acts_as_authentic do |r|
    r.maintain_sessions = false
  end
end
