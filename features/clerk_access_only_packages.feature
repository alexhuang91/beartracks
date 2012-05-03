Feature: Only logged in Clerk can access all package actions

@model
Scenario: When No clerk is Logged in all package actions redirect to home page
  Given there is no clerk logged in
  When I go to the packages page
  Then I should be on the home page
  And I should see "must be logged in"

@model
Scenario: When a clerk is logged in all package actions should not redirect
  Given the following clerk exists:
        | login    | password   | password_confirmation | first_name | last_name |
        | John     | pass       | pass                  | John       | Lennon    |
  And I log in as a clerk through the UI with login "John" and password "pass"
  Then I should be on the packages page
  And I should not see "must be logged in"