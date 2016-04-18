class CreateFuelTypes < ActiveRecord::Migration
  def change
    create_table :fuel_types do |t|
      t.string :type_name
      t.string :unit_of_measurement

      t.timestamps null: false
    end
  end
end
