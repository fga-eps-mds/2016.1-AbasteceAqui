Feature: Generate chart of fuel price over the years
	In order to see the variation of fuel price
	As any kind of user
	Should see a chart

	Scenario: Success in see the yearly variation graphic of fuel price in a State	
		Given I am in the state annual chart page
		And I fill "Escolha o Estado Desejado" with "ACRE"
		Then the statistic page is loaded with the yearly variation graphic of fuel price in 'ACRE'
