Feature: Add a Package

as a clerk
I want to be able to add a package to a database
so that when I view packages, I can see it

Background: Clerk logged in

  Given the following clerk exists:
    | login    | password   | password_confirmation | unit   | first_name | last_name |
    | Tony     | pass       | pass                  | Unit 1 | Tony       | Montana   |

  When I am on the homepage
  When I follow "Clerk Login"
  And I fill in the following:
    | Login     | Tony |
    | Password  | pass |
  And I press "Login"

Scenario: Get to the Add Package page
  When I go to the packages page
  And I follow "Add New Package"
  Then I am on the add package page

Scenario: Add Package with appropriate fields
  When I go to the add package page
  And I fill in the following:
    | Resident Name   | Bilbo  |
    | Tracking Number | 1122   |
    | Building        | Cheney |
    | Room            | 253    |
  When I press "Create Package"
  Then I should be on the packages page
  And I should see "Bilbo"
  And I should see "1122"

Scenario: Add Package without every appropriate field
  When I go to the add package page
  And I fill in the following:
    | Resident Name   | Bilbo  |
    | Building        | Cheney |
    | Room            | 253    |
  When I press "Create Package"
  Then I should be on the add package page
  And I should see "Cannot leave Tracking Number blank"
  Then I follow "Clerk Logout"
