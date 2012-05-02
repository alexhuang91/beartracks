require "authlogic/test_case"

Before ('@model') do
  activate_authlogic
end

##CLERKS##
When /^I log in as a clerk with username "([^"]*)" and password "([^"]*)"$/ do |login, password|
  ClerkSession.create(:login => login, :password => password, :remember_me => true)
end

Then /^the current clerk's login should be "([^"]*)"$/ do |expected_login|
  current_clerk_session = ClerkSession.find
  current_clerk_session.clerk.login.should == expected_login
end

Given /^there are no clerks$/ do
  Clerk.all.count.should == 0
end

Then /^a new Clerk account for "([^"]*)" should be created$/ do |login|
  the_clerk = Clerk.find_by_login(login)
  the_clerk.should_not be_nil
  the_clerk.login.should eq(login)
end

Then /^the clerk account for "([^"]*)" should be an admin account$/ do |login|
  clerk = Clerk.find_by_login(login)
  clerk.should_not be_nil
  clerk.is_admin?.should be_true
end

When /^I log out clerk$/ do
  session = ClerkSession.find
  session.destroy
end

Then /^there should be no clerk logged in$/ do
  session = ClerkSession.find
  session.nil?.should be_true
end

Given /^there is no clerk logged in$/ do
  session = ClerkSession.find
  session.destroy unless session.nil?
end

Then /^the current clerk should be an admin$/ do
  sesh = ClerkSession.find
  sesh.clerk.is_admin?.should be_true
end

Then /^the current clerk should not be an admin$/ do
  sesh = ClerkSession.find
  sesh.clerk.is_admin?.should be_false
end

Then /^I log in as a clerk through the UI with login "([^"]*)" and password "([^"]*)"$/ do |login, password|
  step %Q{I am on the clerk login page}
  step %Q{I fill in "clerk_session_login" with "#{login}"}
  step %Q{I fill in "clerk_session_password" with "#{password}"}
  step %Q{I press "Clerk login"}
end



##RESIDENTS##
When /^I log in as a resident with username "([^"]*)" and password "([^"]*)"$/ do |login, password|
  ResidentSession.create(:login => login, :password => password, :remember_me => true)
end

Then /^the current resident's login should be "([^"]*)"$/ do |expected_value|
  current_session = ResidentSession.find
  current_session.resident.login.should == expected_value
end

Then /^the current resident's first name should be "([^"]*)"$/ do |expected_value|
  current_session = ResidentSession.find
  current_session.resident.first_name.should == expected_value
end

Given /^there are no residents$/ do
  Resident.all.count.should == 0
end

Then /^a new resident account for "([^"]*)" should be created$/ do |login|
  the_resident = Resident.find_by_login(login)
  the_resident.should_not be_nil
  the_resident.login.should eq(login)
end

When /^I log out resident$/ do
  session = ResidentSession.find
  session.destroy
end

Then /^there should be no resident logged in$/ do
  session = ResidentSession.find
  session.nil?.should be_true
end

Then /^I log in as a resident through the UI with login "([^"]*)" and password "([^"]*)"$/ do |login, password|
  step %Q{I am on the resident login page}
  step %Q{I fill in "resident_session_login" with "#{login}"}
  step %Q{I fill in "resident_session_password" with "#{password}"}
  step %Q{I press "Resident login"}
end