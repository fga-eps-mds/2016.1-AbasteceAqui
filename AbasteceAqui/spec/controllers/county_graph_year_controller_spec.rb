require 'rails_helper'

RSpec.describe CountyGraphYearController, type: :controller do

  before do
    state1 = State.new(id: 1, name: "DISTRITO FEDERAL");
    county1 = County.new(id: 1, name: "BRASILIA", state_id: 1)
    fuel_research1 = FuelResearch.new(id: 1, date: "2015-04-01", county_id: 1)
    fuel_research2 = FuelResearch.new(id: 2, date: "2014-05-01", county_id: 1)
    fuel1 = Fuel.new(id: 1, medium_resale_price: 3.0, fuel_type_id: 1, fuel_research_id: 1)
    fuel2 = Fuel.new(id: 2, medium_resale_price: 5.0, fuel_type_id: 2, fuel_research_id: 1)
    fuel3 = Fuel.new(id: 3, medium_resale_price: 4.0, fuel_type_id: 5, fuel_research_id: 2)


    state1.save
    county1.save
    fuel_research1.save
    fuel_research2.save
    fuel1.save
    fuel2.save
    fuel3.save

  end

    describe "#find_all_states comparing by array size" do
      it "should return all states of database" do

        states = controller.get_all_state_names()

        expect(states.count).to eq(1)
      end
    end

    describe "#find_all_states comparing by content value" do
      it "should return all states of database" do

        states = controller.get_all_state_names()

        expect(states).to eq(["DISTRITO FEDERAL"])
      end
    end

    describe "#find_all_counties_of_state_searched comparing by array size" do
      it "should return all counties of state searched" do

        counties_of_state = controller.find_all_counties_of_state_searched("DISTRITO FEDERAL")

        expect(counties_of_state.count).to eq(1)
      end
    end

    describe "#find_all_counties_of_state_searched comparing by content value" do
      it "should return all counties of state searched" do

        counties_of_state = controller.find_all_counties_of_state_searched("DISTRITO FEDERAL")

        expect(counties_of_state).to eq(["BRASILIA"])
      end
    end


    describe "#find_all_researches_of_county_searched comparing by array size" do
      it "should return all researches of county searched" do

        researches_of_county = controller.find_all_researches_of_county_searched("BRASILIA")

        expect(researches_of_county.count).to eq(2)
      end
    end

    describe "#find_all_researches_of_county_searched comparing by id" do
      it "should return all researches of county searched" do

        researches_of_county = controller.find_all_researches_of_county_searched("BRASILIA")

        expect(researches_of_county[0].id).to eq(1)
        expect(researches_of_county[1].id).to eq(2)

      end
    end

    describe "#find_all_years_of_researches comparing by array size" do
      it "should return all years of researches of county searched" do

        researches_of_county = controller.find_all_researches_of_county_searched("BRASILIA")
        years = controller.find_all_years_of_researches(researches_of_county)

        expect(years.count).to eq(2)

      end
    end

    describe "#find_all_years_of_researches comparing by content value" do
      it "should return all years of researches of county searched" do

        researches_of_county = controller.find_all_researches_of_county_searched("BRASILIA")
        years = controller.find_all_years_of_researches(researches_of_county)

        expect(years).to eq([2015,2014])

      end
    end

    describe "#fuels_of_year comparing by array size" do
      it "should return all fuels of selected year of researches of county searched" do

        researches_of_county = controller.find_all_researches_of_county_searched("BRASILIA")
        years = controller.find_all_years_of_researches(researches_of_county)
        fuels_by_year = controller.fuels_of_year(years, researches_of_county)

        expect(fuels_by_year.count).to eq(2)

      end
    end

    describe "#fuels_of_year comparing by id" do
      it "should return all fuels of selected year of researches of county searched" do

        researches_of_county = controller.find_all_researches_of_county_searched("BRASILIA")
        years = controller.find_all_years_of_researches(researches_of_county)
        fuels_by_year = controller.fuels_of_year(years, researches_of_county)

        expect(fuels_by_year["2015"][0].id).to eq(1)
        expect(fuels_by_year["2014"][0].id).to eq(2)

      end
    end

    describe "#find_all_fuels_of_county comparing by array size" do
      it "should return all fuels of selected year of researches of county searched separated by year" do

        researches_of_county = controller.find_all_researches_of_county_searched("BRASILIA")
        years = controller.find_all_years_of_researches(researches_of_county)
        fuels_by_year = controller.fuels_of_year(years, researches_of_county)
        all_fuels = controller.find_all_fuels_of_county(fuels_by_year)

        expect(all_fuels.count).to eq(2)

      end
    end


    describe "#find_all_fuels_of_county comparing by content value" do
      it "should return all fuels of selected year of researches of county searched separated by year" do

        researches_of_county = controller.find_all_researches_of_county_searched("BRASILIA")
        years = controller.find_all_years_of_researches(researches_of_county)
        fuels_by_year = controller.fuels_of_year(years, researches_of_county)
        all_fuels = controller.find_all_fuels_of_county(fuels_by_year)

        expect(all_fuels["2015"][0].id).to eq(1)
        expect(all_fuels["2014"][0].id).to eq(3)
        expect(all_fuels["2015"][2]).to eq(nil)

      end
    end

    describe "#get_prices_of_fuel comparing by array size" do
      it "should return all fuels price of selected year of researches of county searched separated by year" do

        researches_of_county = controller.find_all_researches_of_county_searched("BRASILIA")
        years = controller.find_all_years_of_researches(researches_of_county)
        fuels_by_year = controller.fuels_of_year(years, researches_of_county)
        all_fuels = controller.find_all_fuels_of_county(fuels_by_year)
        fuels_price = controller.get_prices_of_fuel(all_fuels)

        expect(fuels_price.count).to eq(2)

      end
    end

    describe "#get_prices_of_fuel comparing by content value" do
      it "should return all fuels price of selected year of researches of county searched separated by year" do

        researches_of_county = controller.find_all_researches_of_county_searched("BRASILIA")
        years = controller.find_all_years_of_researches(researches_of_county)
        fuels_by_year = controller.fuels_of_year(years, researches_of_county)
        all_fuels = controller.find_all_fuels_of_county(fuels_by_year)
        fuels_price = controller.get_prices_of_fuel(all_fuels)

        expect(fuels_price["2015"][0].id).to eq(1)
        expect(fuels_price["2014"][0].id).to eq(3)
        expect(fuels_price["2015"][2]).to eq(nil)

      end
    end

    describe "#calculate_sum_of_fuels comparing by array size" do
      it "should return all sum of fuel's price of selected year of researches of county searched separated by year" do

        researches_of_county = controller.find_all_researches_of_county_searched("BRASILIA")
        years = controller.find_all_years_of_researches(researches_of_county)
        fuels_by_year = controller.fuels_of_year(years, researches_of_county)
        all_fuels = controller.find_all_fuels_of_county(fuels_by_year)
        fuels_price = controller.get_prices_of_fuel(all_fuels)
        ethanol = Hash.new
        gas = Hash.new
        diesel = Hash.new
        ethanol["2015"] = [2.0, 1.0, 3.0]
        gas["2015"] = [2.0, 1.0, 3.0]
        diesel["2015"] = [2.0, 1.0, 3.0]
        sum_fuels = controller.calculate_sum_of_fuels(ethanol, gas, diesel)

        expect(sum_fuels.count).to eq(3)

      end
    end

    describe "#calculate_sum_of_fuels comparing by content value" do
      it "should return all sum of fuel's price of selected year of researches of county searched separated by year" do

        researches_of_county = controller.find_all_researches_of_county_searched("BRASILIA")
        years = controller.find_all_years_of_researches(researches_of_county)
        fuels_by_year = controller.fuels_of_year(years, researches_of_county)
        all_fuels = controller.find_all_fuels_of_county(fuels_by_year)
        fuels_price = controller.get_prices_of_fuel(all_fuels)
        ethanol = Hash.new
        gas = Hash.new
        diesel = Hash.new
        ethanol["2015"] = [2.0, 1.0, 3.0]
        gas["2015"] = [2.0, 1.0, 9.0]
        diesel["2015"] = [2.0, 1.0, 6.0]
        sum_fuels = controller.calculate_sum_of_fuels(ethanol, gas, diesel)

        expect(sum_fuels).to eq([[2.0],[4.0],[3.0]])

      end
    end

    describe "#index" do
      it "Should render countr_graph_year page" do
        get :index, {:state_searched => "DISTRITO FEDERAL", :county_searched => "BRASILIA"}

        expect(response).to have_http_status(:success)
      end
    end

end #end of class
