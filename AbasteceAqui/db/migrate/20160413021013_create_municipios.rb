class CreateMunicipios < ActiveRecord::Migration
  def change
    create_table :municipios do |t|
      t.string :nome
      t.integer :numero_de_postos

      t.timestamps null: false
    end
  end
end
