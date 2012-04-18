Feature: Package view options for an admin clerk

As an admin
I want to be able to view packages by unit and package pickup status
so that I can limit what packages I see on the packages page

Background: packages in database, admin logged in

  Given the following clerks exist:
    | login    | password   | password_confirmation | unit   | is_admin |
    | Armando  | toucan     | toucan				| Unit 3 |  true	|

  Given there is no clerk logged in
  When I am on the homepage
  When I follow "Clerk Login"
  And I fill in the following:
    | Login     | Armando |
    | Password  | toucan  |
  And I check "Remember me"
  And I press "Login"

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
  And I select "Foothill" from "unit"
  And I select "All packages" from "packages"
  And I press "Refresh List"
  Then I should be on the packages page
  And I should see "No packages for Foothill"
  And I should not see "Case"
  And I should not see "Daniel"
  And I should not see "Kevin"
  And I should not see "Alex"
