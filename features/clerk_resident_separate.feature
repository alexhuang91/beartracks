Feature: Preventing a Clerk logged in from logging in as a resident

Scenario: Clerk Logged in Can't log in as a Resident through interface
  Given the following clerk exists:
    | login    | password   | password_confirmation |
    | Tony     | pass       | pass                  |
  Then I am on the clerk login page
  And I fill in the following:
      | Login     | Tony       |
      | Password  | pass       |
  When I press "Login"
  And the current clerk's login should be "Tony"
  When I go to the resident login page
  Then I should be on the packages page
  When I go to the home page
  And I should not see "Login"
