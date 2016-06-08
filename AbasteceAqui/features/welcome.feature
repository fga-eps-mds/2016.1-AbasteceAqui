Feature: Welcome
	In order to start using the application
	As any kind of user
	Should be able to access any link from the homepage

	Scenario: Goes to the sercher
		Given I am on the welcome page
		And I click on "Pesquisar preços de combustíveis por municípios"
		Then I should see the page to select a state

	Scenario: Goes to the calculator
		Given I am on the welcome page
		And I click on "Calculadora de Rentabilidade"
		Then I should see a calculator page