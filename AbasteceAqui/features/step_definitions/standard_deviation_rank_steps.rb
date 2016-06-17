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


