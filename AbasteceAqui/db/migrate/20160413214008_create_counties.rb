class CreateCounties < ActiveRecord::Migration
  def change
    create_table :counties do |t|
      t.string :name
			t.belongs_to :state
      t.timestamps null: false
    end
  end
end
