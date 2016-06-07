#Scenario 1
Given(/^I am on the welcome page$/) do
  visit 'http://localhost:3000/'
end

Given(/^I click on "Pesquisar preços de combustíveis por municípios"$/) do
  click_link('Pesquisar preços de combustíveis por municípios')
end

Then(/^I should see the page to select a state$/) do
  expect(page).to have_content('Selecione um estado:')
end

#Scenario 2

Given(/^I click on "Calculadora de Rentabilidade"$/) do
  click_link('Calculadora de Rentabilidade')
end

Then(/^I should see a calculator page$/) do
  expect(page).to have_content('Calculadora de Rentabilidade')
end
