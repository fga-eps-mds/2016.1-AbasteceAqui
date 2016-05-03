require "rails_helper"

RSpec.describe CalculatorController, type: :controller do

	describe "GET #index" do
    it "Ethanol is more profitable with exactly 70 percent" do
    	get :index, {:ethanol_price => 7, :gas_price => 10}
      expect(assigns(:more_profitable)).to eq "O Etanol é mais rentável"
    end

    it "Ethanol is more profitable with less than 70 percent" do
			get :index, {:ethanol_price => 6.9, :gas_price => 10}
      expect(assigns(:more_profitable)).to eq "O Etanol é mais rentável"
		end

		it "Gas is more profitable" do
			get :index, {:ethanol_price => 7.1, :gas_price => 10}
      expect(assigns(:more_profitable)).to eq "A Gasolina é mais rentável"
		end

    it "Should be successful" do
      get :index
      expect(response).to be_success
    end

    it "Renders the index templete" do
      get :index
      expect(response).to render_template("index")
    end

  end

end 