Feature: Testing Authlogic

@model
Scenario: Logging in
  Given the following clerk exists:
    | login    | password   | password_confirmation |
    | Tony     | pass       | pass                  |
  When I log in as "Tony" with password "pass"
  Then the current clerk's login should be "Tony"