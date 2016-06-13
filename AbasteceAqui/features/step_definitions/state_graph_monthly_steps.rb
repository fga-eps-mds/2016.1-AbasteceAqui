# Before do
# 	@state = State.new
# 	@state.name = 'ACRE'
# 	@state.id = 1
# 	@state.save
# end

#Scenario 1
Given(/^I am in the monthly state chart page$/) do
  visit '/statistics/state_monthly'
end

When (/^I fill "Escolha o Estado Desejado" field with "ALAGOAS"$/) do 
  	select('ALAGOAS', :from => 'select_tag43')	
end