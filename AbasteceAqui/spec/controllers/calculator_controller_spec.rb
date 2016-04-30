require "rails_helper"

RSpec.describe CalculatorController, type: :controller do
	describe "GET #index" do
    it "Ethanol is more profitable with exactly 70 percent" do
    	get :index, :ethanol_price => 7, :gas_price => 10

      #get :index, params: {ethanol_price: 7, gas_price: 10}
      expect(@more_profitable).to eq "O Etanol é mais rentável"
    end
=begin
    it "Ethanol is more profitable with less than 70 percent" do
			expect(Calculator.calculate(6.9, 10)).to eq "O Etanol é mais rentável"
		end

		it "Gas is more profitable" do
			expect(Calculator.calculate(7.1, 10)).to eq "A Gasolina é mais rentável"
		end
=end

  end



end 
