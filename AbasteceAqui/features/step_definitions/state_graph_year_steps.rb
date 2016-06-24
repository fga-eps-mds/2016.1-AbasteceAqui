#Scenario 1

Given (/^I am in the state annual chart page$/) do
  visit 'http://localhost:3000/statistics/state_annual'
end

And (/^I click on "Gráfico Estadual Anual"$/) do
  click_on('Gráfico Estadual Anual')
end


And (/^I fill "Escolha o Estado Desejado" with "ACRE"$/) do
  find(:xpath, '//span[@id="state_tagSelectBoxIt"]').click
  find('.selectboxit-option[data-val="ACRE"]').click
end

Then(/^the statistic page is loaded with the yearly variation graphic of fuel price in 'ACRE'$/) do
  expect(page).to have_content('Preço Da Gasolina')
end
