class AddColumnFuelTypeToFuel < ActiveRecord::Migration
  def change
    add_column :fuels, :fuel_type, :string
    remove_column :fuels, :type
  end
end
