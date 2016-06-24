class CalculatorController < ApplicationController

	# method that render CalculatorController's view
	def index

		ethanol_price = params[:ethanol_price].to_f
		gas_price = params[:gas_price].to_f

		@more_profitable = calculate_fuel_profitability(ethanol_price, gas_price)

	end

	# receive a two prices of fuels and calculate the profitability of then
	def calculate_fuel_profitability(ethanol_price, gas_price)

		more_profitable = Calculator.calculate(ethanol_price, gas_price)

		return more_profitable

	end

end