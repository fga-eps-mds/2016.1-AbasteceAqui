#Scenario 1
Given(/^I am in the county_monthly page$/) do
  visit 'statistics/county_monthly'
end

When(/^I fill "States" field with "ACRE"$/) do

  	select('ACRE', :from => 'state_county_graph_monthly_select_tag')
end

And(/^I fill "County" field with "CRUZEIRO DO SUL"$/) do

  	select('Cruzeiro do Sul', :from => 'county_county_graph_monthly_select_tag')
end

And(/^I fill "Year" field with "2013"$/) do

  	select('2013', :from => 'year_county_graph_monthly_select_tag')
end

Then(/^the county page is loaded with the monthly variation graphic of fuel price in 'CRUZEIRO DO SUL'$/) do

  page.should have_content('Preço Da Gasolina')

end
