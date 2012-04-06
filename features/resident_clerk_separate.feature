Feature: A logged in resident cannot log in as a clerk

Scenario: Resident Logged in Can't log in as a Clerk through interface
  Given the following resident exists:
    | login    | password   | password_confirmation | email   |
    | Corre     | pass       | pass                  | j@j.com |
  Then I am on the resident login page
  And I fill in the following:
      | Login     | Corre       |
      | Password  | pass       |
  When I press "Login"
  And the current resident's login should be "Corre"
  When I go to the clerk login page
  Then I should be on the home page
  And I should not see "Login"
  And I should not see "Clerk Login"