Feature: Package view options for an admin clerk

As an admin
I want to be able to view packages by unit and package pickup status
so that I can limit what packages I see on the packages page

Background: packages in database, admin logged in

  Given the following clerk exists:
    | login    | password   | password_confirmation | unit   | is_admin |
    | Armando  | toucan     | toucan				| Unit 3 |  true	|

  Then I log in as a clerk through the UI with login "Armando" and password "toucan"

  Given the following packages exist my way:
  | resident_name | tracking_number | unit   | building | room | datetime_received | picked_up | clerk_id |
  | Case          | 123             | Unit 1 | Fire     | 1    | 1977-05-25        | true      | 1        |
  | Daniel        | 234             | Unit 2 | Wind     | 2    | 1982-06-25        | false     | 1        |
  | Kevin         | 345             | Unit 3 | Water    | 3    | 1979-05-25        | true      | 1        |
  | Alex          | 456             | Unit 1 | Air      | 4    | 1971-03-11        | false     | 1        |

Scenario: view all packages in all units
  When I am on the packages page
  When I select "All Units" from "unit"
  When I select "All packages" from "packages"
  And I press "Refresh List"
  Then I should be on the packages page
  And I should see "All packages"
  And I should see "Case"
  And I should see "Daniel"
  And I should see "Kevin"
  And I should see "Alex"

Scenario: view picked up packages in all units
  When I am on the packages page
  And I select "All Units" from "unit"
  And I select "Picked up" from "packages"
  And I press "Refresh List"
  Then I should be on the packages page
  And I should see "All picked up packages"
  And I should see "Case"
  And I should not see "Daniel"
  And I should see "Kevin"
  And I should not see "Alex"

Scenario: view not picked up packages in all units
  When I am on the packages page
  And I select "All Units" from "unit"
  And I select "Not picked up" from "packages"
  And I press "Refresh List"
  Then I should be on the packages page
  And I should see "All not picked up packages"
  And I should not see "Case"
  And I should see "Daniel"
  And I should not see "Kevin"
  And I should see "Alex"

Scenario: view all packages for one unit
  When I am on the packages page
  And I select "Unit 1" from "unit"
  And I select "All packages" from "packages"
  And I press "Refresh List"
  Then I should be on the packages page
  And I should see "All packages for Unit 1"
  And I should see "Case"
  And I should not see "Daniel"
  And I should not see "Kevin"
  And I should see "Alex"

Scenario: view picked up packages for one unit
  When I am on the packages page
  And I select "Unit 1" from "unit"
  And I select "Picked up" from "packages"
  And I press "Refresh List"
  Then I should be on the packages page
  And I should see "All picked up packages for Unit 1"
  And I should see "Case"
  And I should not see "Daniel"
  And I should not see "Kevin"
  And I should not see "Alex"

Scenario: view not picked up packages for one unit
  When I am on the packages page
  And I select "Unit 1" from "unit"
  And I select "Not picked up" from "packages"
  And I press "Refresh List"
  Then I should be on the packages page
  And I should see "All not picked up packages for Unit 1"
  And I should not see "Case"
  And I should not see "Daniel"
  And I should not see "Kevin"
  And I should see "Alex"
  
Scenario: no packages in the database for a particular view
  When I am on the packages page
  And I select "Unit 4" from "unit"
  And I select "All packages" from "packages"
  And I press "Refresh List"
  Then I should be on the packages page
  And I should see "No packages for Unit 4"
  And I should not see "Case"
  And I should not see "Daniel"
  And I should not see "Kevin"
  And I should not see "Alex"

Scenario: go back to the packages page when trying to access a nonexistent package
  When I am on the package details page for package 5
  Then I should be on the packages page
  And I should see "Package 5 doesn't exist."
  
