#Scenario 1
Given(/^I am in the county_monthly page$/) do
  visit 'statistics/county_monthly'
end

When(/^I fill "States" field with "ACRE"$/) do
  find(:xpath, '//span[@id="state_county_graph_monthly_select_tagSelectBoxIt"]').click
  find('.selectboxit-option[data-val="ACRE"]').click
end

And(/^I fill "County" field with "CRUZEIRO DO SUL"$/) do
  find(:xpath, '//span[@id="county_county_graph_monthly_select_tagSelectBoxIt"]').click
  find('.selectboxit-option[data-val="CRUZEIRO DO SUL"]').click
end

And(/^I fill "Year" field with "2013"$/) do
  find(:xpath, '//span[@id="year_county_graph_monthly_select_tagSelectBoxIt"]').click
  find('.selectboxit-option[data-val="2013"]').click
end

Then(/^the county page is loaded with the monthly variation graphic of fuel price in 'CRUZEIRO DO SUL'$/) do
  expect(page).to have_content('Preço Da Gasolina')
end
