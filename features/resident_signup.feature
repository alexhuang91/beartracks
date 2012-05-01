Feature: Testing Authlogic Resident Signup

Background:
  Given the following resident exists:
    | login            | password   | password_confirmation | email   | unit   | building | room | preference | first_name      | last_name | name   |
    | alex             | pass       | pass                  | j@j.com | Unit 1 | Cheney   | 201  | Mail Slip  | Alexander       | Great     | Alex   |
  And I am on the new resident page
  When I fill in the following:
    | Login                 | alexhuang   |
    | Password              | pass        |
    | Password Confirmation | pass        |
    | Email                 | a@a.com     |
    | Building              | Spens-Black |
    | Room                  | 101         |
    | First Name            | Alex        |
    | Last Name             | Huang       |
  And I select "Unit 3" from "Unit"
  And I select "Email" from "Preference"

@model
Scenario: Signup Success
  When I press "Submit"
  Then I should not see "Login is too short (minimum is 3 characters)"

Scenario: Login Taken
  When I fill in the following:
    | Login                 | alex    |
  And I press "Submit"
  Then I should see "Login has already been taken"

Scenario: Email Taken
  When I fill in the following:
    | Email                 | j@j.com |
  When I press "Submit"
  Then I should see "Email has already been taken"

Scenario: Login Too Short
  When I fill in the following:
    | Login                 | a       |
  When I press "Submit"
  Then I should see "Login is too short (minimum is 3 characters)"

Scenario: Invalid login
  When I fill in the following:
    | Login                 | a$#*    |
  When I press "Submit"
  Then I should see "Login should use only letters, numbers, spaces, and .-_@ please."

Scenario: Password Too Short
  When I fill in the following:
    | Password              | a       |
    | Password Confirmation | a       |
  When I press "Submit"
  Then I should see "Password is too short (minimum is 4 characters)"

Scenario: Password confirmation Mismatch
  When I fill in the following:
    | Password              | pass    |
    | Password Confirmation | pasy    |
  When I press "Submit"
  Then I should see "Password doesn't match confirmation"

Scenario: Password confirmation Too Short
  When I fill in the following:
    | Password              | pass    |
    | Password Confirmation | pa      |
  When I press "Submit"
  Then I should see "Password confirmation is too short (minimum is 4 characters)"

Scenario: No First Name
  When I fill in the following:
    | First Name | |
  When I press "Submit"
  Then I should see "First name can't be blank"

Scenario: No Last Name
  When I fill in the following:
    | Last Name | |
  When I press "Submit"
  Then I should see "Last name can't be blank"

Scenario: No Building
  When I fill in the following:
    | Building | |
  When I press "Submit"
  Then I should see "Building can't be blank"

Scenario: No Room
  When I fill in the following:
    | Room | |
  When I press "Submit"
  Then I should see "Room can't be blank"
