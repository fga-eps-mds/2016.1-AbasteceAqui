class AddIndexToFuelResearches < ActiveRecord::Migration
  def change
    add_index :fuel_researches, :county_id
  end
end
