Before do
  state = State.new(id: 1, name: "ACRE", region_id: 1)
  state.save

  county = County.new(name: "CRUZEIRO DO SUL", state_id: 1)
  county.save


  fuel_research = FuelResearch.new(id: 1, county_id: 1, date: "01-01-2013")
  fuel_research.save

  fuel_research_ethanol = Fuel.new(id: 1, fuel_research_id: 2, medium_resale_price: 2, fuel_type_id: 1)
  fuel_research_ethanol.save

  fuel_research_gasoline = Fuel.new(id: 2, fuel_research_id: 2, medium_resale_price: 2, fuel_type_id: 2)
  fuel_research_gasoline.save

  fuel_research_diesel = Fuel.new(id: 3, fuel_research_id: 2, medium_resale_price: 2, fuel_type_id: 5)
  fuel_research_diesel.save
end
