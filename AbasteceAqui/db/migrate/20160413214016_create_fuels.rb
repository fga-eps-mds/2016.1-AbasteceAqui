class CreateFuels < ActiveRecord::Migration
  
  def change
    create_table :fuels do |t|
      t.integer :number_of_gas_station
      t.float :min_resale_price
      t.float :medium_resale_price
      t.float :max_resale_price
      t.float :resale_standard_deviation
      t.float :min_distribuition_price
      t.float :medium_distribuition_price
      t.float :max_distribuition_price
      t.float :distribuition_standard_deviation
      t.belongs_to :fuel_research
      t.belongs_to :fuel_type
      t.timestamps null: false
    end
  
  end

end
