Feature: See conty graph
	In order to see the variation of fuel price
	As any kind of user
	Should see the graphic

  @javascript
	Scenario: Success in see the monthly variation graphic of fuel price in a County
		Given I am in the county_monthly page
    When I fill "States" field with "ACRE"
    And I fill "County" field with "CRUZEIRO DO SUL"
		And I fill "Year" field with "2013"
		Then the county page is loaded with the monthly variation graphic of fuel price in 'CRUZEIRO DO SUL'
