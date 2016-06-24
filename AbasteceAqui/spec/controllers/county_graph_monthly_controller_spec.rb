require 'rails_helper'

RSpec.describe CountyGraphMonthlyController, type: :controller do

  before do
    state1 = State.new(id: 1, name:"DISTRITO FEDERAL")
    state2 = State.new(id:2, name:"RIO DE JANEIRO")
    state1.save
    state2.save

    county1 = County.new(id: 1, name: "BRASILIA", state_id: 1)
    county2= County.new(id: 2, name: "RIO DE JANEIRO", state_id:2)
    county1.save
    county2.save

    fuel_research1 = FuelResearch.new(id: 1, date: "2015-02-01", county_id: 1)
    fuel_research2 = FuelResearch.new(id: 2, date: "2016-02-01", county_id: 2)
    fuel_research1.save
    fuel_research2.save


    fuel1 = Fuel.new(id: 1, number_of_gas_station: 4,
    min_resale_price: 2.199, medium_resale_price: 2.199,
    max_resale_price: 2.199, resale_standard_deviation: 0.0,
    min_distribuition_price: 0.0, medium_distribuition_price: 0.0,
    max_distribuition_price: 0.0, distribuition_standard_deviation: 0.0,
    fuel_research_id: 1, fuel_type_id: 1)
    fuel2 = Fuel.new(id: 2, number_of_gas_station: 4,
    min_resale_price: 2.199, medium_resale_price: 2.299,
    max_resale_price: 2.199, resale_standard_deviation: 0.0,
    min_distribuition_price: 0.0, medium_distribuition_price: 0.0,
    max_distribuition_price: 0.0, distribuition_standard_deviation: 0.0,
    fuel_research_id: 1, fuel_type_id: 2)

    fuel3 = Fuel.new(id: 3, number_of_gas_station: 4,
         min_resale_price: 2.199, medium_resale_price: 2.399,
         max_resale_price: 2.199, resale_standard_deviation: 0.0,
         min_distribuition_price: 0.0, medium_distribuition_price: 0.0,
         max_distribuition_price: 0.0, distribuition_standard_deviation: 0.0,
         fuel_research_id: 2, fuel_type_id: 5)

    fuel1.save
    fuel2.save
    fuel3.save
  end

  describe "#find_all_states comparing by array size" do
    it "should return all states of database" do

      states = controller.find_all_states()

      expect(states.count).to eq(2)

    end
  end

  describe "#find_all_states comparing by array content value" do
    it "should return all states of database" do

      states = controller.find_all_states()

      expect(states[0]).to eq("DISTRITO FEDERAL")
      expect(states[1]).to eq("RIO DE JANEIRO")

    end
  end

  describe "#find_all_counties_of_state_searched comparing by array size" do
    it "should return all counties of state searched" do

      states = controller.find_all_states()

      counties_states_0 = controller.find_all_counties_of_state_searched(states[0])
      counties_states_1 = controller.find_all_counties_of_state_searched(states[1])

      expect(counties_states_0.count).to eq(1)

      expect(counties_states_1.count).to eq(1)

    end
  end

  describe "#find_all_counties_of_state_searched comparing by array content value" do
    it "should return all counties  of state searched" do

      states = controller.find_all_states()

      counties_states_0 = controller.find_all_counties_of_state_searched(states[0])
      counties_states_1 = controller.find_all_counties_of_state_searched(states[1])

      expect(counties_states_0[0]).to eq("BRASILIA")

      expect(counties_states_1[0]).to eq("RIO DE JANEIRO")

    end
  end

  describe "#find_all_researches_of_county_searched comparing by array size" do
    it "should return all research of county searched" do

      county_searched_brasilia = "BRASILIA"
      county_searched_rio_de_janeiro = "RIO DE JANEIRO"

      researches_county_brasilia = controller.find_all_researches_of_county_searched(county_searched_brasilia)
      researches_county_rio_de_janeiro = controller.find_all_researches_of_county_searched(county_searched_rio_de_janeiro)

      expect(researches_county_brasilia.count).to eq(1)

      expect(researches_county_rio_de_janeiro.count).to eq(1)

    end
  end

  describe "#find_all_researches_of_county_searched comparing by id" do
    it "should return all research of county searched" do

      county_searched_brasilia = "BRASILIA"
      county_searched_rio_de_janeiro = "RIO DE JANEIRO"

      researches_county_brasilia = controller.find_all_researches_of_county_searched(county_searched_brasilia)
      researches_county_rio_de_janeiro = controller.find_all_researches_of_county_searched(county_searched_rio_de_janeiro)

      expect(researches_county_brasilia[0].id).to eq(1)

      expect(researches_county_rio_de_janeiro[0].id).to eq(2)

    end
  end

  describe "#find_all_years_of_researches comparing by array size" do
    it "should return all years of researches" do

      county_searched_brasilia = "BRASILIA"
      county_searched_rio_de_janeiro = "RIO DE JANEIRO"

      researches_county_brasilia = controller.find_all_researches_of_county_searched(county_searched_brasilia)
      researches_county_rio_de_janeiro = controller.find_all_researches_of_county_searched(county_searched_rio_de_janeiro)

      years_research_brasilia = controller.find_all_years_of_researches(researches_county_brasilia)
      years_research_rio_de_janeiro = controller.find_all_years_of_researches(researches_county_rio_de_janeiro)

      expect(years_research_brasilia.count).to eq(1)

      expect(years_research_rio_de_janeiro.count).to eq(1)

    end
  end

  describe "#find_all_years_of_researches comparing by content value" do
    it "should return all years of researches" do

      county_searched_brasilia = "BRASILIA"
      county_searched_rio_de_janeiro = "RIO DE JANEIRO"

      researches_county_brasilia = controller.find_all_researches_of_county_searched(county_searched_brasilia)
      researches_county_rio_de_janeiro = controller.find_all_researches_of_county_searched(county_searched_rio_de_janeiro)

      years_research_brasilia = controller.find_all_years_of_researches(researches_county_brasilia)
      years_research_rio_de_janeiro = controller.find_all_years_of_researches(researches_county_rio_de_janeiro)

      expect(years_research_brasilia[0]).to eq(2015)

      expect(years_research_rio_de_janeiro[0]).to eq(2016)

    end
  end

  describe "#find_researches_of_selected_year comparing by array size" do
    it "should return all researches of selected year" do

      county_searched_brasilia = "BRASILIA"
      county_searched_rio_de_janeiro = "RIO DE JANEIRO"

      researches_county_brasilia = controller.find_all_researches_of_county_searched(county_searched_brasilia)
      researches_county_rio_de_janeiro = controller.find_all_researches_of_county_searched(county_searched_rio_de_janeiro)

      researches_brasilia_year = controller.find_researches_of_selected_year("2015", researches_county_brasilia)
      researches_rio_de_janeiro_year = controller.find_researches_of_selected_year("2016", researches_county_rio_de_janeiro)

      expect(researches_brasilia_year.count).to eq(1)

      expect(researches_rio_de_janeiro_year.count).to eq(1)

    end
  end

  describe "#find_researches_of_selected_year comparing by id" do
    it "should return all researches of selected year" do

      county_searched_brasilia = "BRASILIA"
      county_searched_rio_de_janeiro = "RIO DE JANEIRO"

      researches_county_brasilia = controller.find_all_researches_of_county_searched(county_searched_brasilia)
      researches_county_rio_de_janeiro = controller.find_all_researches_of_county_searched(county_searched_rio_de_janeiro)

      researches_brasilia_year = controller.find_researches_of_selected_year("2015", researches_county_brasilia)
      researches_rio_de_janeiro_year = controller.find_researches_of_selected_year("2016", researches_county_rio_de_janeiro)

      expect(researches_brasilia_year[0].id).to eq(1)

      expect(researches_rio_de_janeiro_year[0].id).to eq(2)

    end
  end

  describe "#find_all_fuels_of_county comparing by array size" do
    it "should return all fuels of research's conty of selected year" do

      county_searched_brasilia = "BRASILIA"
      county_searched_rio_de_janeiro = "RIO DE JANEIRO"
      researches_county_brasilia = controller.find_all_researches_of_county_searched(county_searched_brasilia)
      researches_county_rio_de_janeiro = controller.find_all_researches_of_county_searched(county_searched_rio_de_janeiro)
      researches_brasilia = controller.find_researches_of_selected_year("2015", researches_county_brasilia)
      researches_rio_de_janeiro = controller.find_researches_of_selected_year("2016", researches_county_rio_de_janeiro)
      fuels_brasilia = controller.find_all_fuels_of_county(researches_brasilia)
      fuels_rio_de_janeiro = controller.find_all_fuels_of_county(researches_rio_de_janeiro)

      expect(fuels_brasilia.count).to eq(2)

      expect(fuels_rio_de_janeiro.count).to eq(1)

    end
  end

  describe "#find_all_fuels_of_county comparing by id" do
    it "should return all fuels of research's county of selected year" do

      county_searched_brasilia = "BRASILIA"
      county_searched_rio_de_janeiro = "RIO DE JANEIRO"
      researches_county_brasilia = controller.find_all_researches_of_county_searched(county_searched_brasilia)
      researches_county_rio_de_janeiro = controller.find_all_researches_of_county_searched(county_searched_rio_de_janeiro)
      researches_brasilia = controller.find_researches_of_selected_year("2015", researches_county_brasilia)
      researches_rio_de_janeiro = controller.find_researches_of_selected_year("2016", researches_county_rio_de_janeiro)
      fuels_brasilia = controller.find_all_fuels_of_county(researches_brasilia)
      fuels_rio_de_janeiro = controller.find_all_fuels_of_county(researches_rio_de_janeiro)

      expect(fuels_brasilia[0].id).to eq(1)
      expect(fuels_brasilia[1].id).to eq(2)

      expect(fuels_rio_de_janeiro[0].id).to eq(3)

    end
  end

  describe "#find_fuels_of_county_by_month comparing by array size" do
    it "should return all fuels sorted by month of research's county of selected year" do

      county_searched_brasilia = "BRASILIA"
      county_searched_rio_de_janeiro = "RIO DE JANEIRO"

      researches_county_brasilia = controller.find_all_researches_of_county_searched(county_searched_brasilia)
      researches_county_rio_de_janeiro = controller.find_all_researches_of_county_searched(county_searched_rio_de_janeiro)
      researches_brasilia = controller.find_researches_of_selected_year("2015", researches_county_brasilia)
      researches_rio_de_janeiro = controller.find_researches_of_selected_year("2016", researches_county_rio_de_janeiro)

      fuels_brasilia = controller.find_all_fuels_of_county(researches_brasilia)
      fuels_rio_de_janeiro = controller.find_all_fuels_of_county(researches_rio_de_janeiro)

      fuels_month_brasilia = controller.find_fuels_of_county_by_month(fuels_brasilia)
      fuels_month_rio_de_janeiro = controller.find_fuels_of_county_by_month(fuels_rio_de_janeiro)

      expect(fuels_month_brasilia.count).to eq(12)
      expect(fuels_month_brasilia[0].count).to eq(3)

      expect(fuels_month_rio_de_janeiro.count).to eq(12)
      expect(fuels_month_rio_de_janeiro[0].count).to eq(3)

    end
  end

  describe "#find_fuels_of_county_by_month comparing by content value" do
    it "should return all fuels sorted by month of research's county of selected year" do

      county_searched_brasilia = "BRASILIA"
      county_searched_rio_de_janeiro = "RIO DE JANEIRO"

      researches_county_brasilia = controller.find_all_researches_of_county_searched(county_searched_brasilia)
      researches_county_rio_de_janeiro = controller.find_all_researches_of_county_searched(county_searched_rio_de_janeiro)
      researches_brasilia = controller.find_researches_of_selected_year("2015", researches_county_brasilia)
      researches_rio_de_janeiro = controller.find_researches_of_selected_year("2016", researches_county_rio_de_janeiro)

      fuels_brasilia = controller.find_all_fuels_of_county(researches_brasilia)
      fuels_rio_de_janeiro = controller.find_all_fuels_of_county(researches_rio_de_janeiro)

      fuels_month_brasilia = controller.find_fuels_of_county_by_month(fuels_brasilia)
      fuels_month_rio_de_janeiro = controller.find_fuels_of_county_by_month(fuels_rio_de_janeiro)

      expect(fuels_month_brasilia[0]["GASOLINE"]).to eq([])
      expect(fuels_month_brasilia[0]["ETHANOL"]).to eq([])
      expect(fuels_month_brasilia[0]["DIESEL"]).to eq([])

      expect(fuels_month_brasilia[1]["GASOLINE"]).to eq([2.299])
      expect(fuels_month_brasilia[1]["ETHANOL"]).to eq([2.199])
      expect(fuels_month_brasilia[1]["DIESEL"]).to eq([])

      expect(fuels_month_rio_de_janeiro[0]["GASOLINE"]).to eq([])
      expect(fuels_month_rio_de_janeiro[0]["ETHANOL"]).to eq([])
      expect(fuels_month_rio_de_janeiro[0]["DIESEL"]).to eq([])

      expect(fuels_month_rio_de_janeiro[1]["GASOLINE"]).to eq([])
      expect(fuels_month_rio_de_janeiro[1]["ETHANOL"]).to eq([])
      expect(fuels_month_rio_de_janeiro[1]["DIESEL"]).to eq([2.399])

    end
  end

  describe "#sorting_a_fuel_of_county comparing by array size" do
    it "should return gasoline array without hash sorted by month of research's county of selected year" do

      county_searched_brasilia = "BRASILIA"
      county_searched_rio_de_janeiro = "RIO DE JANEIRO"
      fuel_name = "GASOLINE"

      researches_county_brasilia = controller.find_all_researches_of_county_searched(county_searched_brasilia)
      researches_county_rio_de_janeiro = controller.find_all_researches_of_county_searched(county_searched_rio_de_janeiro)
      researches_brasilia = controller.find_researches_of_selected_year("2015", researches_county_brasilia)
      researches_rio_de_janeiro = controller.find_researches_of_selected_year("2016", researches_county_rio_de_janeiro)

      fuels_brasilia = controller.find_all_fuels_of_county(researches_brasilia)
      fuels_rio_de_janeiro = controller.find_all_fuels_of_county(researches_rio_de_janeiro)

      fuels_month_brasilia = controller.find_fuels_of_county_by_month(fuels_brasilia)
      fuels_month_rio_de_janeiro = controller.find_fuels_of_county_by_month(fuels_rio_de_janeiro)

      gasoline_month_brasilia = controller.sorting_a_fuel_of_county(fuels_month_brasilia, fuel_name)
      gasoline_month_rio_de_janeiro = controller.sorting_a_fuel_of_county(fuels_month_rio_de_janeiro, fuel_name)

      expect(gasoline_month_brasilia.count).to eq(12)

      expect(gasoline_month_rio_de_janeiro.count).to eq(12)

    end
  end

  describe "#sorting_a_fuel_of_county comparing by array size" do
    it "should return ethanol array without hash sorted by month of research's county of selected year" do

      county_searched_brasilia = "BRASILIA"
      county_searched_rio_de_janeiro = "RIO DE JANEIRO"
      fuel_name = "ETHANOL"

      researches_county_brasilia = controller.find_all_researches_of_county_searched(county_searched_brasilia)
      researches_county_rio_de_janeiro = controller.find_all_researches_of_county_searched(county_searched_rio_de_janeiro)
      researches_brasilia = controller.find_researches_of_selected_year("2015", researches_county_brasilia)
      researches_rio_de_janeiro = controller.find_researches_of_selected_year("2016", researches_county_rio_de_janeiro)

      fuels_brasilia = controller.find_all_fuels_of_county(researches_brasilia)
      fuels_rio_de_janeiro = controller.find_all_fuels_of_county(researches_rio_de_janeiro)

      fuels_month_brasilia = controller.find_fuels_of_county_by_month(fuels_brasilia)
      fuels_month_rio_de_janeiro = controller.find_fuels_of_county_by_month(fuels_rio_de_janeiro)

      ethanol_month_brasilia = controller.sorting_a_fuel_of_county(fuels_month_brasilia, fuel_name)
      ethanol_month_rio_de_janeiro = controller.sorting_a_fuel_of_county(fuels_month_rio_de_janeiro, fuel_name)

      expect(ethanol_month_brasilia.count).to eq(12)

      expect(ethanol_month_rio_de_janeiro.count).to eq(12)

    end
  end

  describe "#sorting_a_fuel_of_county comparing by array size" do
    it "should return diesel array without hash sorted by month of research's county of selected year" do

      county_searched_brasilia = "BRASILIA"
      county_searched_rio_de_janeiro = "RIO DE JANEIRO"
      fuel_name = "DIESEL"

      researches_county_brasilia = controller.find_all_researches_of_county_searched(county_searched_brasilia)
      researches_county_rio_de_janeiro = controller.find_all_researches_of_county_searched(county_searched_rio_de_janeiro)
      researches_brasilia = controller.find_researches_of_selected_year("2015", researches_county_brasilia)
      researches_rio_de_janeiro = controller.find_researches_of_selected_year("2016", researches_county_rio_de_janeiro)

      fuels_brasilia = controller.find_all_fuels_of_county(researches_brasilia)
      fuels_rio_de_janeiro = controller.find_all_fuels_of_county(researches_rio_de_janeiro)

      fuels_month_brasilia = controller.find_fuels_of_county_by_month(fuels_brasilia)
      fuels_month_rio_de_janeiro = controller.find_fuels_of_county_by_month(fuels_rio_de_janeiro)

      diesel_month_brasilia = controller.sorting_a_fuel_of_county(fuels_month_brasilia, fuel_name)
      diesel_month_rio_de_janeiro = controller.sorting_a_fuel_of_county(fuels_month_rio_de_janeiro, fuel_name)

      expect(diesel_month_brasilia.count).to eq(12)

      expect(diesel_month_rio_de_janeiro.count).to eq(12)

    end
  end

  describe "#sorting_a_fuel_of_county comparing by content value" do
    it "should return gasoline array without hash sorted by month of research's county of selected year" do

      county_searched_brasilia = "BRASILIA"
      county_searched_rio_de_janeiro = "RIO DE JANEIRO"
      fuel_name = "GASOLINE"

      researches_county_brasilia = controller.find_all_researches_of_county_searched(county_searched_brasilia)
      researches_county_rio_de_janeiro = controller.find_all_researches_of_county_searched(county_searched_rio_de_janeiro)
      researches_brasilia = controller.find_researches_of_selected_year("2015", researches_county_brasilia)
      researches_rio_de_janeiro = controller.find_researches_of_selected_year("2016", researches_county_rio_de_janeiro)

      fuels_brasilia = controller.find_all_fuels_of_county(researches_brasilia)
      fuels_rio_de_janeiro = controller.find_all_fuels_of_county(researches_rio_de_janeiro)

      fuels_month_brasilia = controller.find_fuels_of_county_by_month(fuels_brasilia)
      fuels_month_rio_de_janeiro = controller.find_fuels_of_county_by_month(fuels_rio_de_janeiro)

      gasoline_month_brasilia = controller.sorting_a_fuel_of_county(fuels_month_brasilia, fuel_name)
      gasoline_month_rio_de_janeiro = controller.sorting_a_fuel_of_county(fuels_month_rio_de_janeiro, fuel_name)

      expect(gasoline_month_brasilia[0]).to eq(nil)
      expect(gasoline_month_brasilia[1]).to eq([2.299])

      expect(gasoline_month_rio_de_janeiro[0]).to eq(nil)

    end
  end

  describe "#sorting_a_fuel_of_county comparing by content value" do
    it "should return ethanol array without hash sorted by month of research's county of selected year" do

      county_searched_brasilia = "BRASILIA"
      county_searched_rio_de_janeiro = "RIO DE JANEIRO"
      fuel_name = "ETHANOL"

      researches_county_brasilia = controller.find_all_researches_of_county_searched(county_searched_brasilia)
      researches_county_rio_de_janeiro = controller.find_all_researches_of_county_searched(county_searched_rio_de_janeiro)
      researches_brasilia = controller.find_researches_of_selected_year("2015", researches_county_brasilia)
      researches_rio_de_janeiro = controller.find_researches_of_selected_year("2016", researches_county_rio_de_janeiro)

      fuels_brasilia = controller.find_all_fuels_of_county(researches_brasilia)
      fuels_rio_de_janeiro = controller.find_all_fuels_of_county(researches_rio_de_janeiro)

      fuels_month_brasilia = controller.find_fuels_of_county_by_month(fuels_brasilia)
      fuels_month_rio_de_janeiro = controller.find_fuels_of_county_by_month(fuels_rio_de_janeiro)

      ethanol_month_brasilia = controller.sorting_a_fuel_of_county(fuels_month_brasilia, fuel_name)
      ethanol_month_rio_de_janeiro = controller.sorting_a_fuel_of_county(fuels_month_rio_de_janeiro, fuel_name)

      expect(ethanol_month_brasilia[0]).to eq(nil)
      expect(ethanol_month_brasilia[1]).to eq([2.199])

      expect(ethanol_month_rio_de_janeiro[0]).to eq(nil)

    end
  end

  describe "#sorting_a_fuel_of_county comparing by content value" do
    it "should return diesel array without hash sorted by month of research's county of selected year" do

      county_searched_brasilia = "BRASILIA"
      county_searched_rio_de_janeiro = "RIO DE JANEIRO"
      fuel_name = "DIESEL"

      researches_county_brasilia = controller.find_all_researches_of_county_searched(county_searched_brasilia)
      researches_county_rio_de_janeiro = controller.find_all_researches_of_county_searched(county_searched_rio_de_janeiro)
      researches_brasilia = controller.find_researches_of_selected_year("2015", researches_county_brasilia)
      researches_rio_de_janeiro = controller.find_researches_of_selected_year("2016", researches_county_rio_de_janeiro)

      fuels_brasilia = controller.find_all_fuels_of_county(researches_brasilia)
      fuels_rio_de_janeiro = controller.find_all_fuels_of_county(researches_rio_de_janeiro)

      fuels_month_brasilia = controller.find_fuels_of_county_by_month(fuels_brasilia)
      fuels_month_rio_de_janeiro = controller.find_fuels_of_county_by_month(fuels_rio_de_janeiro)

      diesel_month_brasilia = controller.sorting_a_fuel_of_county(fuels_month_brasilia, fuel_name)
      diesel_month_rio_de_janeiro = controller.sorting_a_fuel_of_county(fuels_month_rio_de_janeiro, fuel_name)

      expect(diesel_month_brasilia[0]).to eq(nil)

      expect(diesel_month_rio_de_janeiro[0]).to eq(nil)
      expect(diesel_month_rio_de_janeiro[1]).to eq([2.399])

    end
  end

  describe "GET #index" do
    it "Should render county_graph_monthly page" do
      get :index, {:state_searched => "DISTRITO FEDERAL", :county_searched => "BRASILIA", :year_selected => "2015"}
      expect(response).to have_http_status(:success)

    end
  end

end
