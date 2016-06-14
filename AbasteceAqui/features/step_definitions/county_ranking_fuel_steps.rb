Before do
  fuel_research = FuelResearch.new
  fuel_research.id = 2
  fuel_research.county_id = 1
  fuel_research.save

  fuel_research_ethanol = Fuel.new
  fuel_research_ethanol.id = 1
  fuel_research_ethanol.fuel_research_id = 2
  fuel_research_ethanol.medium_resale_price = 2
  fuel_research_ethanol.fuel_type_id = 1
  fuel_research_ethanol.save

  fuel_research_gasoline = Fuel.new
  fuel_research_gasoline.id = 2
  fuel_research_gasoline.fuel_research_id = 2
  fuel_research_gasoline.medium_resale_price = 2
  fuel_research_gasoline.fuel_type_id = 2
  fuel_research_gasoline.save

  fuel_research_diesel = Fuel.new
  fuel_research_diesel.id = 3
  fuel_research_diesel.fuel_research_id = 2
  fuel_research_diesel.medium_resale_price = 2
  fuel_research_diesel.fuel_type_id = 5
  fuel_research_diesel.save
end

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
