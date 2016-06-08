#Scenario 1

Given(/^I am in the calculator page$/) do
  visit 'http://localhost:3000/calculator'
end

And (/^I fill the "Etanol" with "3"$/) do
	fill_in 'ethanol_price', :with => '3'
end

And (/^I fill the "Gasolina" with "3.9"$/) do
	fill_in 'gas_price', :with => '3.9'
end


When(/^I press "Calcular"$/) do
  click_button('Calcular')
end

Then (/^the page will show that the gas is more profitable$/) do
	expect(page).to have_css("img[src*='gas_more_profitable.jpg']")
end

#Scenario 2
And (/^I fill the "Etanol" with "2.5"$/) do
	fill_in 'ethanol_price', :with => '2.5'
end

And (/^I fill the "Gasolina" with "4"$/) do
	fill_in 'gas_price', :with => '4'
end

Then (/^the page will show that the ethanol is more profitable$/) do
	expect(page).to have_css("img[src*='ethanol_more_profitable.jpg']")
end
