Feature: See Statistics
	In order to see the variation of fuel price
	As any kind of user
	Should see the graphic

	Scenario: Success in see the yearly variation graphic of fuel price in a County	
		Given I am in the statistics page
		When I fill "Escolha o Estado Desejado" field with "Acre"
		And I fill "Escolha o Municipio Desejado" field with "Cruzeiro do Sul"
		Then the statistic page is loaded with the yearly variation graphic of fuel price in 'Cruzeiro do Sul'