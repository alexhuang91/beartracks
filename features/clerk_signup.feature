Feature: Clerk Account Creation

Background: Make a clerk exist
  Given the following clerk exists:
     | login    | password   | password_confirmation | email   | first_name | last_name |
     | Tony     | pass       | pass                  | j@j.com | Tony       | Montana   |

@model
Scenario: Login Taken
  Given I am on the new clerk page
  And I fill in the following:
    | Login                 | Tony    |
    | Password              | pass    |
    | Password confirmation | pass    |
    | Email                 | a@a.com |
  When I press "Submit"
  Then I should be on the new clerk page
  And I should see "Login has already been taken"

Scenario: Email Taken
  Given I am on the new clerk page
  And I fill in the following:
    | Login                 | John    |
    | Password              | pass    |
    | Password confirmation | pass    |
    | Email                 | j@j.com |
  When I press "Submit"
  Then I should be on the new clerk page
  And I should see "Email has already been taken"

Scenario: Login Too Short
  Given I am on the new clerk page
  And I fill in the following:
    | Login                 | a       |
    | Password              | pass    |
    | Password confirmation | pass    |
    | Email                 | a@a.com |
  When I press "Submit"
  Then I should be on the new clerk page
  And I should see "Login is too short (minimum is 3 characters)"

Scenario: Invalid login
  Given I am on the new clerk page
  And I fill in the following:
    | Login                 | a$#*    |
    | Password              | pass    |
    | Password confirmation | pass    |
    | Email                 | a@a.com |
  When I press "Submit"
  Then I should be on the new clerk page
  And I should see "Login should use only letters, numbers, spaces, and .-_@ please."

Scenario: Password Too Short
  Given I am on the new clerk page
  And I fill in the following:
    | Login                 | John    |
    | Password              | a       |
    | Password confirmation | a       |
    | Email                 | a@a.com |
  When I press "Submit"
  Then I should be on the new clerk page
  And I should see "Password is too short (minimum is 4 characters)"

Scenario: Password confirmation Mismatch
  Given I am on the new clerk page
  And I fill in the following:
    | Login                 | a       |
    | Password              | pass    |
    | Password confirmation | pasy    |
    | Email                 | a@a.com |
  When I press "Submit"
  Then I should be on the new clerk page
  And I should see "Password doesn't match confirmation"

Scenario: Password confirmation Too Short
  Given I am on the new clerk page
  And I fill in the following:
    | Login                 | John    |
    | Password              | pass    |
    | Password confirmation | pa      |
    | Email                 | a@a.com |
  When I press "Submit"
  Then I should be on the new clerk page
  And I should see "Password confirmation is too short (minimum is 4 characters)"

Scenario: Signup Success
  Given I am on the new clerk page
  And I fill in the following:
    | Login                 | John    |
    | First name            | John    |
    | Last name             | Lennon  |
    | Password              | pass    |
    | Password confirmation | pass    |
    | Email                 | a@a.com |
  When I press "Submit"
  Then I should be on the packages page
  And I should see "Clerk account successfully created"
  And I should not see "Login is too short (minimum is 3 characters)"

