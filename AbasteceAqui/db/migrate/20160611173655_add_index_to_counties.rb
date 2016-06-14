class AddIndexToCounties < ActiveRecord::Migration
  def change
    add_index :counties, :name
  end
end
