class CreateRegioes < ActiveRecord::Migration
  def change
    create_table :regioes do |t|
      t.string :nome

      t.timestamps null: false
    end
  end
end
