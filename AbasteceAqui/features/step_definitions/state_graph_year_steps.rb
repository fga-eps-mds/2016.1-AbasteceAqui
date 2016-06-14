#Scenario 1	

Given (/^I am in the state annual chart page$/) do
  visit 'http://localhost:3000/statistics/state_annual'
end

And (/^I click on "Gráfico Estadual Anual"$/) do
  click_on('Gráfico Estadual Anual')
end


And (/^I fill "Escolha o Estado Desejado" with "ACRE"$/) do 
  	select('ACRE', :from => 'select_tag')
  	click_on('select_button')		
end

Then(/^the statistic page is loaded with the yearly variation graphic of fuel price in 'ACRE'$/) do
  page.should have_content('Estatísticas')
end
