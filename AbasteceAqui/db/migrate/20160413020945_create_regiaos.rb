class CreateRegiaos < ActiveRecord::Migration
  def change
    create_table :regiaos do |t|
      t.string :nome

      t.timestamps null: false
    end
  end
end
