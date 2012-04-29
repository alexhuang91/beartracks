Feature: Package view options for a regular clerk

As a clerk
I want to be able to view packages by package pickup status
so that I can limit what packages I see on the packages page

Background: packages in database, clerk logged in

  Given the following clerk exists:
    | login    | password   | password_confirmation | unit   | is_admin |
    | Timy     | pass       | pass                  | Unit 1 |  false   |

  Given there is no clerk logged in
  When I am on the homepage
  When I follow "Clerk Login"
  And I fill in the following:
    | Login     | Timy |
    | Password  | pass |
  And I check "Remember me"
  And I press "Login"

  Given the following packages exist my way:
  | resident_name | tracking_number | unit   | building | room | datetime_received | picked_up | clerk_id |
  | Case          | 123             | Unit 1 | Fire     | 1    | 1977-05-25        | true      | 1        |
  | Daniel        | 234             | Unit 2 | Wind     | 2    | 1982-06-25        | false     | 1        |
  | Kevin         | 345             | Unit 3 | Water    | 3    | 1979-05-25        | true      | 1        |
  | Alex          | 456             | Unit 1 | Air      | 4    | 1971-03-11        | false     | 1        |

Scenario: view all packages in the clerk's unit
  When I am on the packages page
  When I select "All packages" from "packages"
  And I press "Refresh List"
  Then I should be on the packages page
  And I should see "All packages for Unit 1"
  And I should see "Case"
  And I should not see "Daniel"
  And I should not see "Kevin"
  And I should see "Alex"


Scenario: sort the packages by resident name on the landing page
  When I am on the packages page
  And I press "Resident Name"
  Then I should be on the packages page
  And I should see "Alex" before "Kevin"

Scenario: sort the packages by datetime received on the landing page
  When I am on the packages page
  And I press "Arrival Time"
  Then I should be on the packages page
  And I should see "Daniel" before "Kevin"


Scenario: view all picked up packages in the clerk's unit
  When I am on the packages page
  And I select "Picked up" from "packages"
  And I press "Refresh List"
  Then I should be on the packages page
  And I should see "All picked up packages for Unit 1"
  And I should see "Case"
  And I should not see "Daniel"
  And I should not see "Kevin"
  And I should not see "Alex"

Scenario: view all not picked up packages in the clerk's unit
  When I am on the packages page
  And I select "Not picked up" from "packages"
  And I press "Refresh List"
  Then I should be on the packages page
  And I should see "All not picked up packages for Unit 1"
  And I should not see "Case"
  And I should not see "Daniel"
  And I should not see "Kevin"
  And I should see "Alex" 

Scenario: clerk can search for a package
  When I am on the packages page
  And I select "Tracking Number" from "search_option"
  And I fill in the following:
    | search_string | 123 |
  And I press "Search"
  Then I should be on the packages page
  And I should see "Search results"
  And I should see "Case"
  And I should not see "Daniel"
  And I should not see "Kevin"
  And I should not see "Alex" 
