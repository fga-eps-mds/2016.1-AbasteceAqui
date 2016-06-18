Feature: County ranking by standard deviation
	In order to see the county with less deviation of price
	As any kind of user
	Should see the rank

	@javascript
	Scenario: Success in see ethanol rank
    Given I am in the standard deviation rank page
    And I click on "Etanol Tab" 
    Then the page ranking by etanol deviation is loaded

	@javascript
	Scenario: Success in see gasoline rank
	Given I am in the standard deviation rank page
    And I click on "Gasolina Tab"
    Then the page ranking by gasolina deviation is loaded

	@javascript
  	Scenario: Success in see diesel rank
    Given I am in the standard deviation rank page
    And I click on "Diesel Tab"
    Then the page ranking by diesel is loaded deviation