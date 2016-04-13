class CreateCombustiveis < ActiveRecord::Migration
  def change
    create_table :combustiveis do |t|
      t.string :tipo
      t.float :preco_minimo_revenda
      t.float :preco_medio_revenda
      t.float :preco_maximo_revenda
      t.float :desvio_padrao_revenda
      t.float :preco_minimo_distribuicao
      t.float :preco_medio_distribuicao
      t.float :preco_maximo_distribuicao
      t.float :desvio_padrao_distribuicao
      t.string :data

      t.timestamps null: false
    end
  end
end
