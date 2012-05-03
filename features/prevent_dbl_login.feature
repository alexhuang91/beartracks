Feature: Clerks and Residents cannot be simultaneously logged in within a session

Scenario: Resident Logged in Can't log in as a Clerk through interface
  Given the following resident exists:
    | login | password | password_confirmation | email          | unit   | building | room | preference | first_name      | last_name |
    | Corre | pass     | pass                  | mail@email.com | Unit 2 | Cheney   | 510  | Email      | Alex            | Corre     |
  Then I am on the resident login page
  When I log in as a resident through the UI with login "Corre" and password "pass"
  And the current resident's login should be "Corre"
  When I go to the clerk login page
  Then I should be on the home page
  And I should not see "Login"
  And I should not see "Clerk Login"
  
Scenario: Clerk Logged in Can't log in as a Resident through interface
  Given the following clerk exists:
    | login    | password   | password_confirmation | first_name | last_name |
    | Tony     | pass       | pass                  | Tony       | Montana   |
  Then I am on the clerk login page
  When I log in as a clerk through the UI with login "Tony" and password "pass"
  And the current clerk's login should be "Tony"
  When I go to the resident login page
  Then I should be on the packages page
  When I go to the home page
  And I should not see "Login"
