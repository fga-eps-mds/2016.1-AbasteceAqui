Feature: See statistics
	In order to see the variation of fuel price in a State in a year
	As any kind of user
	Should see the graphic

	Scenario: Success in see the monthly variation graphic of fuel price in a State in a year
		Given I am in the monthly state chart page
		When I fill "Escolha o Estado Desejado" with "ACRE "
		And I fill 'Ecolha o Ano Desejado'  with "2013"
		Then the statistics page is load with the monthly variation graphic of fuel price in "ACRE" in the year of "2013"
