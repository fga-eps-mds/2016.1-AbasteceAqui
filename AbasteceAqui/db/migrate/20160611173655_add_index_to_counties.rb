class AddIndexToCounties < ActiveRecord::Migration
  def change
    add_index :counties, :name
    add_index :counties, :state_id
  end
end
