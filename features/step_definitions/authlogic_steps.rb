require "authlogic/test_case"

Before ('@model') do
  activate_authlogic
end

When /^I log in as "([^"]*)" with password "([^"]*)"$/ do |login, password|
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