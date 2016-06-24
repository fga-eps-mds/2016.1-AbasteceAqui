Feature: See contry graph
	In order to see the variation of fuel price
	As any kind of user
	Should see the graphic

  @javascript
	Scenario: Success in see the monthly variation graphic of fuel price in a Country
		Given I am in the country_monthly page
		When I fill "Escolha o ano Desejado" field with "2013"
		Then the country page is loaded with the monthly variation graphic of fuel price in 'Brasil'
