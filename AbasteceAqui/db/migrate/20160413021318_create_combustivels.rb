class CreateCombustivels < ActiveRecord::Migration
  def change
    create_table :combustivels do |t|
      t.string :tipo
      t.double :preco_minimo_revenda
      t.double :preco_medio_revenda
      t.double :preco_maximo_revenda
      t.double :desvio_padrao_revenda
      t.double :preco_minimo_distribuicao
      t.double :preco_medio_distribuicao
      t.double :preco_maximo_distribuicao
      t.double :desvio_padrao_distribuicao
      t.string :data

      t.timestamps null: false
    end
  end
end
