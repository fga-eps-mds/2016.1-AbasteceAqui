#Scenario 1
Given(/^I am in the country_monthly page$/) do
  visit '/statistics/country_monthly'
end

When(/^I fill "Escolha o ano Desejado" field with "2013"$/) do
  find(:xpath, '//span[@id="year_tagSelectBoxIt"]').click
  find('.selectboxit-option[data-val="2013"]').click
end

Then(/^the country page is loaded with the monthly variation graphic of fuel price in 'Brasil'$/) do
  expect(page).to have_content('Preço Da Gasolina')
end
