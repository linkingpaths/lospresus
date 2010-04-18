class CreateCapitulos < ActiveRecord::Migration
  def self.up
    create_table :capitulos do |t|
      t.references :presupuesto
      t.integer :capitulo
      t.decimal :ingresos, :precision => 10, :scale => 2
      t.decimal :gastos, :precision => 10, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :capitulos
  end
end
