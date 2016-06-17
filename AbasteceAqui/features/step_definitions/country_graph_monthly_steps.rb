#Scenario 1
Given(/^I am in the country_monthly page$/) do
  visit '/statistics/country_monthly'
end

When(/^I fill "Escolha o ano Desejado" field with "2013"$/) do 
  select('2013', :from => 'select_tag')
end

Then(/^the country page is loaded with the monthly variation graphic of fuel price in 'Brasil'$/) do
  page.should have_content('Preço Da Gasolina')
end
