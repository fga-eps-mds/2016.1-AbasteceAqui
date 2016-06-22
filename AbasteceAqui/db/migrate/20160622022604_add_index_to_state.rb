class AddIndexToState < ActiveRecord::Migration
  def change
    add_index :states, :region_id
  end
end
