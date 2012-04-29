Feature: Testing Resident Settings Page

Background: I am logged in as a user and I look at my settings
  Given the following resident exists:
    | login | password | password_confirmation | email   | first name |
    | Tony  | pass     | pass                  | j@j.com | Nottony    |
  And I am on the resident login page
  When I fill in the following:
    | Login    | Tony |
    | Password | pass |
  When I press "Login"
  Then I should see "You have successfully logged in."
  When I follow "My Profile"
  Then I should see "Resident Profile"
  Then I should not see "Istony"
  Then I should not see "mylastname"
  Then I should see "Resident Profile"
  Then I should see "Email: "
  Then I should see "j@j.com"
  When I follow "Edit"
  Then I should see "Edit resident profile"
  And I fill in the following:
    | First name | Istony     |
    | Last name  | mylastname |

@model
Scenario: Simple update
  When I press "Update"
  Then I should see "Resident Profile"
  Then I should see "Istony"
  Then I should see "mylastname"

Scenario: Click Beartracks
  When I follow "BearTracks"
  Then the current resident's first name should be "Nottony"
Scenario: Click Settings
  When I follow "BearTracks"
  Then I should see "My Profile"
  Then the current resident's first name should be "Nottony"

Scenario: Click Logout
  When I follow "Resident Logout"
  Then I should see "You have successfully logged out"
  Then there should be no resident logged in

Scenario: Bad password update
  When I fill in the following:
    | Password             | mypass         |
    | Password confirmation| notthesamepass |
  When I press "Update"
  Then I should see "Please fix the following errors:"
  Then I should see "Password doesn't match confirmation"
