Feature: Edit a Package

As a clerk
I want to be able to edit a package in the database
so that when I make a mistake entering information, I can correct it

Background: Clerk logged in

  Given the following clerk exists:
    | login    | password   | password_confirmation | unit   |
    | Tony     | pass       | pass                  | Unit 1 |

  When I am on the homepage
  When I follow "Clerk Login"
  And I fill in the following:
    | Login     | Tony |
    | Password  | pass |
  And I press "Login"

Scenario: view a package's details

Scenario: edit a package's information with all required fields

Scenario: edit a package's information without filling all required fields

Scenario: cancel an update operation

Scenario: go back to the packages list from the edit form

Scenario: delete a package

Scenario: mark a package as picked up