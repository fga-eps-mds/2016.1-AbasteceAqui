class CreateFuelResearches < ActiveRecord::Migration
  def change
    create_table :fuel_researches do |t|
      t.date :date

      t.timestamps null: false
    end
  end
end
