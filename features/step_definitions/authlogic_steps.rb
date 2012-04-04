require "authlogic/test_case"

Before ('@model') do
  activate_authlogic
end

##CLERKS##
When /^I log in as a clerk with username "([^"]*)" and password "([^"]*)"$/ do |login, password|
  ClerkSession.create(:login => login, :password => password, :remember_me => true)
end

Then /^the current clerk's login should be "([^"]*)"$/ do |expected_login|
  current_session = ClerkSession.find
  current_session.clerk.login.should == expected_login
end

Given /^there are no clerks$/ do
  Clerk.all.count.should == 0
end

Then /^a new Clerk account for "([^"]*)" should be created$/ do |login|
  the_clerk = Clerk.find_by_login(login)
  the_clerk.should_not be_nil
  the_clerk.login.should eq(login)
end

When /^I log out$/ do
  session = ClerkSession.find
  session.destroy
end

Then /^there should be no clerk logged in$/ do
  session = ClerkSession.find
  session.nil?.should be_true
end


##RESIDENTS##
When /^I log in as a resident with username "([^"]*)" and password "([^"]*)"$/ do |login, password|
  ResidentSession.create(:login => login, :password => password, :remember_me => true)
end

Then /^the current resident's login should be "([^"]*)"$/ do |expected_login|
  current_session = ResidentSession.find
  current_session.resident.login.should == expected_login
end

Given /^there are no resident$/ do
  Resident.all.count.should == 0
end

Then /^a new resident account for "([^"]*)" should be created$/ do |login|
  the_resident = Resident.find_by_login(login)
  the_resident.should_not be_nil
  the_resident.login.should eq(login)
end

When /^I log out$/ do
  session = ResidentSession.find
  session.destroy
end

Then /^there should be no resident logged in$/ do
  session = ResidentSession.find
  session.nil?.should be_true
end
