require "rails_helper"

RSpec.describe Calculator, type: :model do 
	
	describe "#calculate" do
		it "Ethanol is more profitable with exactly 70 percent" do
			expect(Calculator.calculate(7, 10)).to eq "O Etanol é mais rentável"
		end

		it "Ethanol is more profitable with less than 70 percent" do
			expect(Calculator.calculate(6.9, 10)).to eq "O Etanol é mais rentável"
		end

		it "Gas is more profitable" do
			expect(Calculator.calculate(7.1, 10)).to eq "A Gasolina é mais rentável"
		end

	end
end 

