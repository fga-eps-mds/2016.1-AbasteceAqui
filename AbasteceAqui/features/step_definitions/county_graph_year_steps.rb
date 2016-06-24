#Scenario 1
Given(/^I am in the statistics page$/) do
  visit '/statistics/county_anual'
end

When (/^I fill "Escolha o Estado Desejado" field with "Acre"$/) do
  find(:xpath, '//span[@id="state_tagSelectBoxIt"]').click
  find('.selectboxit-option[data-val="ACRE"]').click
end

And (/^I fill "Escolha o Municipio Desejado" field with "Cruzeiro do Sul"$/) do
  find(:xpath, '//span[@id="county_tagSelectBoxIt"]').click
  find('.selectboxit-option[data-val="CRUZEIRO DO SUL"]').click
end

Then(/^the statistic page is loaded with the yearly variation graphic of fuel price in 'Cruzeiro do Sul'$/) do
  expect(page).to have_content('Preço Da Gasolina')
end
