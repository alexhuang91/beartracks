class Resident < ActiveRecord::Base
  has_many :packages
  acts_as_authentic do |r|
    r.maintain_sessions = false
  end
end
