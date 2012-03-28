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