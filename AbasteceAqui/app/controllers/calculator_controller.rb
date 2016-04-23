class CalculatorController < ApplicationController

	def is_ethanol_more_profitable?
		@ethanol_price = params[:ethanol_price].to_f
		@gas_price = params[:gas_price].to_f

		profitability_calculation = @ethanol_price / @gas_price

		@a = nil
		
		if profitability_calculation <= 0.7
			@a = true
		elsif profitability_calculation > 0.7
			@a = false
		end

		return @a
	end
end