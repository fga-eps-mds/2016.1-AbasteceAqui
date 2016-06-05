require 'rails_helper'

RSpec.describe StatisticsController, type: :controller do

  before do
    @state1 = State.new(id: 1, name: "DISTRITO FEDERAL");
    @county1 = County.new(id: 1, name: "BRASILIA", state_id: 1)

    @state1.save
    @county1.save

  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #county_anual" do
    it "returns http success when state_searched != nil" do
      get :county_anual, {:state_searched => @state1.name}
      expect(response).to have_http_status(:success)
  end

  it "returns http success when county_searched != nil" do
    get :county_anual, {:county_searched => @county1.name}
    expect(response).to have_http_status(:success)
  end
end

end
