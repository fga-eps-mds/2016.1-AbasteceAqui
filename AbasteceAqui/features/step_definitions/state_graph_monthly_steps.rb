#Scenario 1
Given(/^I am in the monthly state chart page$/) do
  visit '/statistics/state_monthly'
end

When (/^I fill "Escolha o Estado Desejado" with "ACRE "$/) do
  find(:xpath, '//span[@id="state_tagSelectBoxIt"]').click
  find('.selectboxit-option[data-val="ACRE"]').click
end


When(/^I fill 'Ecolha o Ano Desejado'  with "([^"]*)"$/) do |year|
  find(:xpath, '//span[@id="year_tagSelectBoxIt"]').click
  find('.selectboxit-option[data-val="2013"]').click
end


Then(/^the statistics page is load with the monthly variation graphic of fuel price in "([^"]*)" in the year of "([^"]*)"$/) do |arg1, arg2|
  expect(page).to have_content('Preço Da Gasolina')
end
