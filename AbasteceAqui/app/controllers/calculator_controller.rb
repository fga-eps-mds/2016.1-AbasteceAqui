class CalculatorController < ApplicationController
	#Vai pra model ou helper!!!
	#Atualizar o diagrama de pacotes 
	#As variaveis de precos são locais ou instâncias ?
	#Receber os preços como parametros
	def index
		ethanol_price = params[:ethanol_price].to_f
		gas_price = params[:gas_price].to_f

		@more_profitable = Calculator.calculate(ethanol_price, gas_price)
	end

end