class AddIndexToFuels < ActiveRecord::Migration
  def change
    add_index :fuels, :medium_resale_price
    add_index :fuels, :fuel_research_id
    add_index :fuels, :fuel_type_id
  end
end
