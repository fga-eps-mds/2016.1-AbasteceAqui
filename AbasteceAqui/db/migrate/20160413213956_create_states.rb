class CreateStates < ActiveRecord::Migration
 
  def change
    create_table :states do |t|
      t.string :name
	  	t.belongs_to :region
      t.timestamps null: false
    end
 
  end

end
