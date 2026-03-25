class CreateVehicles < ActiveRecord::Migration[7.2]
  def change
    create_table :vehicles do |t|
      t.string :external_id
      t.string :title
      t.string :marca
      t.string :modelo
      t.integer :ano
      t.integer :preco
      t.integer :km
      t.text :descricao
      t.boolean :importada
      t.boolean :destaque
      t.string :estado
      t.date :published_on

      t.timestamps
    end
  end
end
