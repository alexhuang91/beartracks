Feature: Add a Package

as a clerk
I want to be able to add a package to a database
so that when I view packages, I can see it

Background: Clerk logged in

  Given the following clerk exists:
    | login    | password   | password_confirmation | unit   | first_name | last_name |
    | Tony     | pass       | pass                  | Unit 1 | Tony       | Montana   |

  When I am on the homepage
  Then I log in as a clerk through the UI with login "Tony" and password "pass"

Scenario: Get to the Add Package page
  When I go to the packages page
  And I follow "Add New Package"
  Then I am on the add package page

Scenario: Add Package with all required fields
  When I go to the add package page
  And I fill in the following:
    | Resident First Name | Bilbo       |
    | Resident Last Name  | Cool        |
    | Tracking Number     | 1122        |
    | Room                | 253         |
  And I select "Unit 1" from "Unit"
  And I select "Cheney Hall" from "Building"
  When I press "Save Package"
  Then I should be on the packages page
  And I should see "Bilbo"
  And I should see "1122"

Scenario: Add Package without all required fields 
  When I go to the add package page
  And I fill in the following:
    | Resident First Name | Bilbo  |
    | Resident Last Name  | Cool   |
    | Room                | 253    |
  And I select "Unit 1" from "Unit"
  And I select "Cheney Hall" from "Building"
  When I press "Save Package"
  Then I should be on the add package page
  And I should see "Cannot leave Tracking Number blank."

Scenario: Add Package without filling in any fields
  When I go to the add package page
  When I press "Save Package"
  Then I should be on the add package page
  And I should see "Cannot leave Resident First Name, Resident Last Name, Room, or Tracking Number blank."

Scenario: Save and add another package
  When I go to the add package page
  And I fill in the following:
    | Resident First Name | Bilbo  |
    | Resident Last Name  | Cool   |
    | Tracking Number     | 1122   |
    | Room                | 253    |
  And I select "Unit 1" from "Unit"
  And I select "Cheney Hall" from "Building"
  When I press "Save and Create Another Package"
  Then I should be on the add package page
  And I should see "Package created successfully."

Scenario: Cancel an add package operation
  Given the following packages exist:
    | resident_first_name | resident_last_name | tracking_number | unit   | building    | room | datetime_received | picked_up | clerk_id |
    | Case                | Walker             | 1SFELKJ23       | Unit 1 | Cheney Hall | 1    | 1977-05-25        | true      | 1        |
  When I go to the packages page
  Then I should see "1SFELKJ23"
  When I go to the add package page
  And I fill in the following:
    | Resident First Name | Bilbo  |
    | Resident Last Name  | Cool   |
    | Tracking Number     | 1122   |
    | Room                | 253    |
  And I follow "Cancel"
  Then I should be on the packages page
  And I should see "1SFELKJ23"
  And I should not see "1122"

