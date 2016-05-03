class CalculatorController < ApplicationController

	def index

		ethanol_price = params[:ethanol_price].to_f
		gas_price = params[:gas_price].to_f

		@more_profitable = Calculator.calculate(ethanol_price, gas_price)

	end

end