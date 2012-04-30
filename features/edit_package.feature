Feature: Edit a Package

As a clerk
I want to be able to edit a package in the database
so that when I make a mistake entering information, I can correct it

Background: Clerk logged in

  Given the following clerks exist:
    | login    | password   | password_confirmation | unit   | is_admin |
    | Tony     | pass       | pass                  | Unit 1 |   true   |
    | Tiny     | pass       | pass                  | Unit 1 |   false  |

  Then I log in as a clerk through the UI with login "Tony" and password "pass"

  Given the following packages exist my way:
  | resident_name | tracking_number | unit   | building | room | datetime_received | picked_up | clerk_id | sender_city | sender_state | sender_zip |
  | Case          | 123             | Unit 1 | Fire     | 1    | 1977-05-25        | false     | 1        | Berkeley	| CA		   | 94704		| 

Scenario: view a package's details
  Given I am on the packages page
  When I follow "view details"
  Then I should be on the package details page for package 1	
  And I should see "Details for package 1"
  And I should see "Case"
  When I follow "Back to package list"
  Then I should be on the packages page

Scenario: edit a package's information with all required fields
  Given I am on the package details page for package 1	
  When I follow "Edit"
  Then I should be on the edit package page for package 1
  And I should see "Edit package"
  And I fill in the following:
    | Resident Name   | Bilbo  |
    | Tracking Number | 1122   |
    | Building        | Cheney |
    | Room            | 253    |
  When I press "Update" 
  Then I should be on the package details page for package 1
  And I should see "Details for package 1"
  And I should see "Bilbo"
  And I should see "1122"
  And I should see "Cheney"
  And I should see "253"
  And I should see "Package was updated successfully."  

Scenario: edit a package's information without filling all required fields
  Given I am on the package details page for package 1	
  When I follow "Edit"
  Then I should be on the edit package page for package 1
  And I should see "Edit package"
  And I fill in the following:
    | Resident Name   | Bilbo  |
    | Tracking Number |        |
    | Building        | Cheney |
    | Room            | 253    |
  When I press "Update" 
  Then I should be on the edit package page for package 1
  And I should see "Edit package"
  And I should see "Cannot leave Tracking Number blank."

Scenario: mark a package as picked up from the details page
  Given I am on the packages page
  When I select "Not picked up" from "packages"
  And I press "Refresh List"
  Then I should be on the packages page
  And I should see "All not picked up packages"
  And I should see "Case"
  When I follow "view details"
  Then I should be on the package details page for package 1	
  When I follow "Mark as picked up"
  Then I should be on the packages page
  And I should see "Package was marked as picked up."
  And I should not see "Case"

Scenario: mark a package as not picked up from the details page
  Given I am on the package details page for package 1
  When I follow "Mark as picked up"
  Then I should be on the packages page
  And I should see "Package was marked as picked up."
  When I select "Picked up" from "packages"
  And I press "Refresh List"
  Then I should be on the packages page
  And I should see "All picked up packages"
  And I should see "Case"
  Given I am on the package details page for package 1
  When I follow "Mark as not picked up"
  Then I should be on the packages page
  And I should see "Package was marked as not picked up."
  And I should not see "Case"

Scenario: toggle pickup status of a package from the packages page
  Given I am on the packages page
  When I follow "_"
  Then I should be on the packages page
  And I should see "Case"
  And I should see "Package was marked as picked up."
  When I follow "_"
  Then I should be on the packages page
  And I should see "Case"
  And I should see "Package was marked as not picked up."

Scenario: delete a package as an admin
  Given I am on the packages page
  Then I should see "All packages"
  And I should see "Case"
  When I follow "view details"
  Then I should be on the package details page for package 1	
  When I follow "Delete"
  Then I should be on the packages page
  And I should see "Package was deleted successfully."
  And I should not see "Case"

Scenario: clerks can't delete packages
  When I am on the home page
  And I follow the "clerk logout" link
  Then I follow the "clerk login" link
  And I fill in the following:
    | Login     | Tiny |
    | Password  | pass |
  And I press "Login"
  Then I should be on the packages page
  When I am on the package details page for package 1 
  Then I should not see "Delete"

Scenario: Cancel an edit package operation
  When I am on the edit package page for package 1
  And I fill in the following:
    | Resident Name   | Bilbo  |
    | Tracking Number | 1122   |
    | Building        | Cheney |
    | Room            | 253    |
  And I follow "Cancel"
  Then I should be on the package details page for package 1
  And I should see "123"
  And I should not see "1122"
