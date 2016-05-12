require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

	describe "GET #welcome/index" do

		it "Renders the index templete" do

      get :welcome
      expect(response).to render_template("welcome/index")
      
    end

	end

end