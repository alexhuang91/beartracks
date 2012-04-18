Feature: Edit a Package

As a clerk
I want to be able to edit a package in the database
so that when I make a mistake entering information, I can correct it

Background: Clerk logged in

  Given the following clerk exists:
    | login    | password   | password_confirmation | unit   | is_admin |
    | Tony     | pass       | pass                  | Unit 1 |   true   |

  When I am on the homepage
  When I follow "Clerk Login"
  And I fill in the following:
    | Login     | Tony |
    | Password  | pass |
  And I press "Login"

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
  And I should see "Package was not updated successfully."  

Scenario: cancel an update operation
  Given I am on the package details page for package 1	
  When I follow "Edit"
  Then I should be on the edit package page for package 1
  And I should see "Edit package"
  When I follow "Cancel" 
  Then I should be on the package details page for package 1	
  And I should see "Details for package 1"

Scenario: go back to the packages list from the edit form
  Given I am on the package details page for package 1	
  When I follow "Edit"
  Then I should be on the edit package page for package 1
  And I should see "Edit package"
  When I follow "Back to package list" 
  Then I should be on the packages page

Scenario: mark a package as picked up
  Given I am on the packages page
  When I select "Not picked up" from "packages"
  And I press "Refresh List"
  Then I should be on the packages page
  And I should see "All not picked up packages"
  And I should see "Case"
  When I follow "view details"
  Then I should be on the package details page for package 1	
  When I follow "Picked up"
  Then I should be on the packages page
  And I should see "Package was picked up."
  And I should not see "Case"

Scenario: delete a package
  Given I am on the packages page
  Then I should see "All packages"
  And I should see "Case"
  When I follow "view details"
  Then I should be on the package details page for package 1	
  When I follow "Delete"
  Then I should be on the packages page
  And I should see "Package was deleted successfully."
  And I should not see "Case"
