class Resident < ActiveRecord::Base
  #additional validations that Authlogic does not handle
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :unit, :presence => true
  validates :building, :presence => true
  validates :room, :presence => true
  validates :preference, :presence => true
  acts_as_authentic do |r|
    r.maintain_sessions = false
  end
end
