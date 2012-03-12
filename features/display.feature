Feature: Display a list of packages sorted by tracking number
 
	As a desk clerk, I should be able to see packages in order of tracking number.
 
Given the following packages exist:
| Tracking # | Resident Name | DateTime Received | Carrier | Clerk Entered | Unit | Building | Room # | DateTime Accepted | Clerk Accepted | Sender Address | Sender City | Sender State | Sender Zip | Resident SID |
| 234435 	| Bearcub   	| 2012-12-23 09:00 | USPS | Foo | Unit 2 | Ehrman | 401 | null | null | 12345 Cool St | Berkeley | CA | 94704 | 12345678 |
| 111111 	| Bearcub2    | 2012-12-23 09:30 | USPS | Foo | Unit 2 | Ehrman | 401 | null | null | 12345 Cool St | Berkeley | CA | 94704 | 12345678 |
| 111119 	| Bearcub3    | 2012-12-23 09:30 | USPS | Foo | Unit 2 | Ehrman | 401 | null | null | 12345 Cool St | Berkeley | CA | 94704 | 12345678 |
| 123456 	| Bearcub4    | 2012-12-23 09:30 | USPS | Foo | Unit 2 | Ehrman | 401 | null | null | 12345 Cool St | Berkeley | CA | 94704 | 12345678 |
 
And I am on the Clerks Landing Page
 
Scenario:
	Given I press “Tracking #”
	Then I should see 111111 before 111119
	And I should see 111119 before 123456
	And I should see 123456 before 234435
