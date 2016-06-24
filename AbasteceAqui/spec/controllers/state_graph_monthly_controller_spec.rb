require 'rails_helper'

RSpec.describe StateGraphMonthlyController, type: :controller do

  before do
    @state1 = State.new(id: 1, name: "DISTRITO FEDERAL");
    @county1 = County.new(id: 1, name: "BRASILIA", state_id: 1)
    @county2 = County.new(id: 2, name: "GAMA", state_id: 3)
    @fuel_research1 = FuelResearch.new(id: 1, date: "2015-04-01", county_id: 1)
    @fuel_research2 = FuelResearch.new(id: 2, date: "2014-05-01", county_id: 1)
    @fuel1 = Fuel.new(id: 1, medium_resale_price: 3.0, fuel_type_id: 1, fuel_research_id: 1)
    @fuel2 = Fuel.new(id: 2, medium_resale_price: 5.0, fuel_type_id: 2, fuel_research_id: 1)
    @fuel3 = Fuel.new(id: 3, medium_resale_price: 4.0, fuel_type_id: 5, fuel_research_id: 1)


    @state1.save
    @county1.save
    @county2.save
    @fuel_research1.save
    @fuel_research2.save
    @fuel1.save
    @fuel2.save
    @fuel3.save

  end

  describe "GET #state_monthly" do
    it "returns http success when state_searched != nil" do
      get :state_monthly, {:state_searched => @state1.name , :years => 2013}
      expect(response).to have_http_status(:success)
    end
  end

  describe "#get_all_states" do
    it "return all states name" do
      states = controller.get_all_states()

      states_name = []
      # get all states name
      for state in State.all

        states_name << state.name

      end

      expect(states).to eq(states_name)
    end
  end

  describe "#get_all_years_from_researches" do
    it "return all db years" do
      years = controller.get_all_years_from_researches()
      expect(years).to eq([2015,2014])
    end
  end

  describe "#find_years" do
    it "should return all years" do
      years = controller.get_all_years_from_researches()
      expect(years.count).to eq(2)
    end
  end

  describe "find_researches_of_year" do
    it "should return all researches of the year" do
      researches = controller.find_researches_of_year(@state1.name, 2015)
      expect(researches.count).to eql(1)
    end
  end

  describe "#separete_fuels_of_researches" do
    it "separate the researches's fuels" do
      researches = controller.find_researches_of_year(@state1.name, 2015)
      fuels = controller.get_fuels_of_researches(researches)
      expect(fuels[0].medium_resale_price).to eq(3.0)
    end
  end

  describe "#separate_fuels_by_month" do
    it "separate the fuels by month" do
      fuels = Fuel.all
      fuels_month = controller.separate_fuels_by_month(fuels)
      expect(fuels[0].medium_resale_price).to eq(3.0)
    end
  end

end
