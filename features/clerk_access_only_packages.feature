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
        | login    | password   | password_confirmation |
        | John     | pass       | pass                  |
    And I am on the clerk login page
    And I fill in the following:
        | Login     | John       |
        | Password  | pass       |
    When I press "Login"
  Then I should be on the packages page
  And I should not see "must be logged in"