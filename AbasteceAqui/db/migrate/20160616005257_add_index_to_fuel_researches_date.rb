class AddIndexToFuelResearchesDate < ActiveRecord::Migration
  def change
    add_index :fuel_researches, :date
  end
end
