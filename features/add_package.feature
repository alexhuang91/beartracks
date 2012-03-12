Feature: Add package

As a clerk, I should be able to add a package into the database

Scenario: Save a package
	Given I am on the Add Package Page
	When I fill in “Tracking #“ with “1234“
	When I fill in “Resident Name” with “abcdef”
	And I press “Save”
	Then the Resident_Name of “1234“ should be “abcdef“

Scenario: No Tracking Number
	Given I am on the Add Package Page
	And I press “Save”
	Then I should be on the Add Package Page
	And I should see “Package must have a tracking number”
