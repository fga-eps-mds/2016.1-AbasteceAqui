#Scenario 1
Given(/^I am in the statistics page$/) do
  visit '/statistics/county_anual'
end

When (/^I fill "Escolha o Estado Desejado" field with "Acre"$/) do
  	select('ACRE', :from => 'select_tag')
  	click_on('select_button')
end

And (/^I fill "Escolha o Municipio Desejado" field with "Cruzeiro do Sul"$/) do
	select('Cruzeiro do Sul', :from => 'select_tag1')
end

Then(/^the statistic page is loaded with the yearly variation graphic of fuel price in 'Cruzeiro do Sul'$/) do
  page.should have_content('Estatísticas')
end
