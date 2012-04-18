Feature: simple viewing options on the packages page to limit which packages are listed

as a clerk
I want to be able to search by unit and package type
so that I can limit what packages I see on the packages page

Background: packages in database, clerk logged in

  Given the following clerk exists:
    | login    | password   | password_confirmation | unit   |
    | Timy     | pass       | pass                  | Unit 1 |

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

Scenario: viewing all packages in all units
  When I am on the packages page
  Then I am on the packages page
#  When I select "All Units" from "unit"
  When I select "All Packages" from "packages"
  And I press "Refresh List"
  Then I should be on the packages page
  And I should see "Case"
  And I should not see "Daniel"
  And I should not see "Kevin"
  And I should see "Alex"

#Scenario: limit packages to one unit
#  When I am on the packages page
#  And I select "Unit 1" from "unit"
#  And I select "All Packages" from "packages"
#  And I press "Refresh List"
#  Then I should be on the packages page
#  And I should see "Case"
#  And I should not see "Daniel"
#  And I should not see "Kevin"
#  And I should see "Alex"

Scenario: limit packages to picked up
  When I am on the packages page
#  And I select "All Units" from "unit"
  And I select "Picked up" from "packages"
  And I press "Refresh List"
  Then I should be on the packages page
  And I should see "Case"
  And I should not see "Daniel"
  And I should not see "Kevin"
  And I should not see "Alex"

Scenario: limit packages to in house
  When I am on the packages page
#  And I select "All Units" from "unit"
  And I select "Not picked up" from "packages"
  And I press "Refresh List"
  Then I should be on the packages page
  And I should not see "Case"
  And I should not see "Daniel"
  And I should not see "Kevin"
  And I should see "Alex"

#Scenario: limit packages to one unit and picked up
#  When I am on the packages page
#  And I select "Unit 1" from "unit"
#  And I select "Picked up" from "packages"
#  And I press "Refresh List"
#  Then I should be on the packages page
#  And I should see "Case"
#  And I should not see "Daniel"
#  And I should not see "Kevin"
#  And I should not see "Alex"
