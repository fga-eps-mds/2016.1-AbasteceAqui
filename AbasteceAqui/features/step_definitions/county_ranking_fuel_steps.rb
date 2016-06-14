#Scenario 1
Given(/^I am in the county ranking page$/) do
  visit '/statistics/ranking_county'
end

Given(/^I click on "Etanol"$/) do
  click_link('Etanol')
end

Then(/^the page ranking by etanol is loaded$/) do
  page.should have_content('Rank Preços Etanol')
end

#Scenario 2
Given(/^I click on "Diesel"$/) do
  click_link('Diesel')
end

Then(/^the page ranking by diesel is loaded$/) do
  page.should have_content('Rank Preços Diesel')
end

#Scenario 3
Given(/^I click on "Gasolina"$/) do
  click_link('Gasolina')
end

Then(/^the page ranking by gasolina is loaded$/) do
  page.should have_content('Rank Preços Gasolina')
end
