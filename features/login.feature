Feature: Clerk can login and see Landing Page

As a clerk, I should be able to Log In

Given the following clerk exists:
|Username|Password|Unit|
|foo     |bar     | 3  |

Given the following packages exists:
| Tracking #    | Resident Name| DateTime Received | Carrier | Clerk Entered | Unit | Building | Room # | DateTime Accepted | Clerk Accepted | Sender Address | Sender City | Sender State | Sender Zip | Resident SID |
| 234435 	| Bearcub      | 2012-12-23 09:00  | USPS | Foo | Unit 2 | Ehrman | 401 | null | null | 12345 Cool St | Berkeley | CA | 94704 | 12345678 |
| 111111 	| Bearcub2     | 2012-12-23 09:30  | USPS | Foo | Unit 2 | Ehrman | 401 | null | null | 12345 Cool St | Berkeley | CA | 94704 | 12345678 |
| 111119 	| Bearcub3     | 2012-12-23 09:30  | USPS | Foo | Unit 2 | Ehrman | 401 | null | null | 12345 Cool St | Berkeley | CA | 94704 | 12345678 |
| 123456 	| Bearcub4     | 2012-12-23 09:30  | USPS | Foo | Unit 2 | Ehrman | 401 | null | null | 12345 Cool St | Berkeley | CA | 94704 | 12345678 |


Scenario: Go to login page
	Given I am on the BearTracks Homepage
	And I press “login”
	Then I should be on the login page

Scenario: Successful Login from login page
	Given I am on the login page
	And I fill in “username” with “foo”
	And I fill in “password” with “bar”
	And I press “submit” 
	Then I should be on the Landing Page
	And I should see 111111

Scenario: Unsuccessful Login from login page
	Given I am on the login page
	And I fill in “username” with “cool”
	And I press “submit”
	Then I should be on the login page
	And I should see “Incorrect Username And/Or Password”
