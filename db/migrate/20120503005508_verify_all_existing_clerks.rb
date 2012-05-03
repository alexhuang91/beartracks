class VerifyAllExistingClerks < ActiveRecord::Migration
  def up
    Clerk.all.each do |clerk|
      clerk.verify!
    end
  end

  def down
    Clerk.all.each do |clerk|
      clerk.verified = false
      clerk.save!
    end
  end
end
