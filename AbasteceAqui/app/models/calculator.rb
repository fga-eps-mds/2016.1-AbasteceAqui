class Calculator

	def self.calculate(ethanol_price, gas_price)

		profitability_calculation = ethanol_price / gas_price
		
		more_profitable = nil

		profitability_coefficient = 0.7
		
		if profitability_calculation <= profitability_coefficient
			more_profitable = "O Etanol é mais rentável"
		elsif profitability_calculation > profitability_coefficient
			more_profitable = "A Gasolina é mais rentável"
		end

		return more_profitable
	end
end 