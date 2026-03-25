class CreateWorks < ActiveRecord::Migration[7.2]
  def change
    create_table :works do |t|
      t.string :external_id
      t.string :titulo
      t.string :tipo
      t.text :pedido_cliente
      t.text :solucao
      t.text :resultado
      t.date :published_on

      t.timestamps
    end
  end
end
