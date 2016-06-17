Feature: County ranking by standard deviation
	In order to see the county with less deviation of price
	As any kind of user
	Should see the rank

	@javascript
	Scenario: Success in see ethanol rank
    Given I am in the county ranking page
    And I click on "Etanol"
    Then the page ranking by etanol is loaded

	@javascript
	Scenario: Success in see gasoline rank
	Given I am in the county ranking page
    And I click on "Gasolina"
    Then the page ranking by gasolina is loaded

	@javascript
  	Scenario: Success in see diesel rank
    Given I am in the county ranking page
    And I click on "Diesel"
    Then the page ranking by diesel is loaded