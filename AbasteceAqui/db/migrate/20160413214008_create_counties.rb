class CreateCounties < ActiveRecord::Migration
  
  def change
    create_table :counties do |t|
      t.string :name
      t.integer :number_of_gas_station
			t.belongs_to :state
      t.timestamps null: false
    end
 
  end

end
