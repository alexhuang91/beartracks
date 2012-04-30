# a layer of abstraction from UI linkage

link_hash = {"clerk login" => "CLERK LOGIN", 
             "clerk logout" => "LOGOUT",
             "resident login" => "Resident Login",
             "resident logout" => "LOGOUT"}

When /^I follow the "([^"]*)" link$/ do |link|
  step %Q{I follow "#{link_hash[link]}"}
end

Then /^I should see the "([^"]*)" link$/ do |link|
  step %Q{I should see "#{link_hash[link]}"}
end

Then /^I should not see the "([^"]*)" link$/ do |link|
  step %Q{I should not see "#{link_hash[link]}"}
end