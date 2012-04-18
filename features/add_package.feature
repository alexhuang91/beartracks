Feature: Add a Package

as a clerk
I want to be able to add a package to a database
so that when I view packages, I can see it

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

Scenario: Get to the Add Package page
  When I go to the packages page
  And I follow "Add New Package"
  Then I am on the add package page

Scenario: Add Package with all required fields
  When I go to the add package page
  And I fill in the following:
    | Resident Name   | Bilbo  |
    | Tracking Number | 1122   |
    | Building        | Cheney |
    | Room            | 253    |
  When I press "Save Package"
  Then I should be on the packages page
  And I should see "Bilbo"
  And I should see "1122"

Scenario: Add Package without all required fields 
  When I go to the add package page
  And I fill in the following:
    | Resident Name   | Bilbo  |
    | Building        | Cheney |
    | Room            | 253    |
  When I press "Save Package"
  Then I should be on the add package page
  And I should see "Cannot leave Tracking Number blank"

Scenario: Add Package without filling in any fields
  When I go to the add package page
  When I press "Save Package"
  Then I should be on the add package page
  And I should see "Cannot leave Resident Name, Building, Room, or Tracking Number blank"

Scenario: Save and add another package
  When I go to the add package page
  And I fill in the following:
    | Resident Name   | Bilbo  |
    | Tracking Number | 1122   |
    | Building        | Cheney |
    | Room            | 253    |
  When I press "Save and Create Another Package"
  Then I should be on the add package page
  And I should see "Package created successfully."
  
Scenario: Cancel an add package operation
  Given the following packages exist:
    | resident_name | tracking_number | unit   | building | room | datetime_received | picked_up | clerk_id |
    | Case          | 1SFELKJ23       | Unit 1 | Fire     | 1    | 1977-05-25        | true      | 1        |
  When I go to the packages page
  Then I should see "1SFELKJ23"
  When I go to the add package page
  And I fill in the following:
    | Resident Name   | Bilbo  |
    | Tracking Number | 1122   |
    | Building        | Cheney |
    | Room            | 253    |
  And I press "Cancel"
  Then I should be on the packages page
  And I should see "1SFELKJ23"
  And I should not see "1122"

