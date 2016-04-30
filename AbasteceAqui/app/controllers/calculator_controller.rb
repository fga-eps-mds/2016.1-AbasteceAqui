class CalculatorController < ApplicationController
	#Vai pra model ou helper!!!
	#Atualizar o diagrama de pacotes 
	#As variaveis de precos são locais ou instâncias ?
	#Receber os preços como parametros
	
	def is_ethanol_more_profitable?
		@ethanol_price = params[:ethanol_price].to_f
		@gas_price = params[:gas_price].to_f

		profitability_calculation = @ethanol_price / @gas_price

		@answer = nil
		
		if profitability_calculation <= 0.7
			@answer = true
		elsif profitability_calculation > 0.7
			@answer = false
		end

		return @answer
	end
end