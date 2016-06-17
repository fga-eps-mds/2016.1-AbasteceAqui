#Scenario 1
Given(/^I am in the standard deviation rank page$/) do
  visit '/statistics/ranking_deviation'
end

Given(/^I click on "Etanol Tab"$/) do
  click_link('Etanol')
end

Then(/^the page ranking by etanol deviation is loaded$/) do
  page.should have_content('Rank Preços Etanol')
end


#Scenario 2
Given(/^I click on "Diesel Tab"$/) do
  click_link('Diesel')
end

Then(/^the page ranking by diesel is loaded deviation$/) do
  page.should have_content('Rank Preços Diesel')
end
