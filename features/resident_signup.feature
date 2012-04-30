Feature: Testing Authlogic Resident Signup

@model
Scenario: Login Taken
  Given the following resident exists:
    | login    | password   | password_confirmation | email   |
    | Tony     | pass       | pass                  | j@j.com |
  And I am on the new resident page
  And I fill in the following:
    | Login                 | Tony    |
    | Password              | pass    |
    | Password Confirmation | pass    |
    | Email                 | a@a.com |
  When I press "Submit"
  Then I should see "Login has already been taken"

Scenario: Email Taken
  Given the following resident exists:
    | login    | password   | password_confirmation | email   |
    | Tony     | pass       | pass                  | j@j.com |
  And I am on the new resident page
  And I fill in the following:
    | Login                 | John    |
    | Password              | pass    |
    | Password Confirmation | pass    |
    | Email                 | j@j.com |
  When I press "Submit"
  Then I should see "Email has already been taken"

Scenario: Login Too Short
  Given I am on the new resident page
  And I fill in the following:
    | Login                 | a       |
    | Password              | pass    |
    | Password Confirmation | pass    |
    | Email                 | a@a.com |
  When I press "Submit"
  Then I should see "Login is too short (minimum is 3 characters)"

Scenario: Invalid login
  Given I am on the new resident page
  And I fill in the following:
    | Login                 | a$#*    |
    | Password              | pass    |
    | Password Confirmation | pass    |
    | Email                 | a@a.com |
  When I press "Submit"
  Then I should see "Login should use only letters, numbers, spaces, and .-_@ please."

Scenario: Password Too Short
  Given I am on the new resident page
  And I fill in the following:
    | Login                 | John    |
    | Password              | a       |
    | Password Confirmation | a       |
    | Email                 | a@a.com |
  When I press "Submit"
  Then I should see "Password is too short (minimum is 4 characters)"

Scenario: Password confirmation Mismatch
  Given I am on the new resident page
  And I fill in the following:
    | Login                 | a       |
    | Password              | pass    |
    | Password Confirmation | pasy    |
    | Email                 | a@a.com |
  When I press "Submit"
  Then I should see "Password doesn't match confirmation"

Scenario: Password confirmation Too Short
  Given I am on the new resident page
  And I fill in the following:
    | Login                 | John    |
    | Password              | pass    |
    | Password Confirmation | pa      |
    | Email                 | a@a.com |
  When I press "Submit"
  Then I should see "Password confirmation is too short (minimum is 4 characters)"

Scenario: Signup Success
  Given I am on the new resident page
  And I fill in the following:
    | Login                 | John    |
    | Password              | pass    |
    | Password Confirmation | pass    |
    | Email                 | a@a.com |
  When I press "Submit"
  Then I should not see "Login is too short (minimum is 3 characters)"

