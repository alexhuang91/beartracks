Feature: Testing Resident Settings Page

Background: I am logged in as a user and I look at my settings
  Given the following resident exists:
    | login | password | password_confirmation | email   | unit   | building | room | preference | first_name      | last_name |
    | Tony  | pass     | pass                  | j@j.com | Unit 3 | Priestly | 202  | Email      | Nottony         | Pizzaman  |
    | Alex  | pass     | pass                  | p@p.com | Unit 2 | Cheney   | 101  | Mail Slip  | Alex            | Great     |
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
  And I fill in the following:
    | First Name | Istony     |
    | Last Name  | mylastname |

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
  When I follow the "resident logout" link
  Then I should see "You have successfully logged out"
  Then there should be no resident logged in
  When I go to the resident show page for resident 1
  Then I should be on the home page
  Then I should see "Sorry, you don't have access to that!"

Scenario: Bad password update
  When I fill in the following:
    | Password             | mypass         |
    | Password Confirmation| notthesamepass |
  When I press "Update"
  Then I should see "Please fix the following errors:"
  Then I should see "Password doesn't match confirmation"

Scenario: No logged in tries to go to residents/4
  When I follow the "resident logout" link
  Then I should see "You have successfully logged out"
  When I go to the resident show page for resident 4
  Then I should see "Sorry, you don't have access to that!"

Scenario: Resident tries to access another resident settings
  When I go to the resident show page for resident 2
  Then I should be on the residents page
  Then I should see "Sorry, you don't have access to that!"

Scenario: Clerk tried to access resident settings
  When I follow the "resident logout" link
  Given the following clerk exists:
    | login    | password   | password_confirmation | unit   | email            | is_admin | first_name | last_name |
    | Paul     | pass       | pass                  | Unit 1 | paul@beatles.com | false    | Paul       | McCartney |
  When I log in as a clerk through the UI with login "Paul" and password "pass"
  When I go to the resident show page for resident 1
  Then I should be on the packages page
  Then I should see "Sorry, you don't have access to that!"
