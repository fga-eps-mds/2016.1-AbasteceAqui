Feature: Calculate Profitability
	In order to find out which fuel is more profitable  
	As any kind of user 
	Should calculate the profitability

	Scenario: Finds out which fuel is more profitable  
		Given I am in the calculator page 
		And I fill the "Etanol" with "3"
		And I fill the "Gasolina" with "3.9"
		When I press "Calcular"
		Then the page will show that the gas is more profitable

	Scenario: Finds out which fuel is more profitable  
		Given I am in the calculator page 
		And I fill the "Etanol" with "2.5"
		And I fill the "Gasolina" with "4"
		When I press "Calcular"
		Then the page will show that the ethanol is more profitable