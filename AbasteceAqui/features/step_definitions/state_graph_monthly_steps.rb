#Scenario 1
Given(/^I am in the monthly state chart page$/) do
  visit '/statistics/state_monthly'
end

When (/^I fill "Escolha o Estado Desejado" with "ACRE "$/) do
  	select('ACRE', :from => 'select_tag')
end


When(/^I fill 'Ecolha o Ano Desejado'  with "([^"]*)"$/) do |year|
	select(year, :from => 'select_tag1')
	click_on('select_button')
end


Then(/^the statistics page is load with the monthly variation graphic of fuel price in "([^"]*)" in the year of "([^"]*)"$/) do |arg1, arg2|
	page.should have_content('Estatísticas')
end
