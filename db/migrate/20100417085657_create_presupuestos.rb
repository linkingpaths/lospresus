class CreatePresupuestos < ActiveRecord::Migration
  def self.up
    create_table :presupuestos do |t|
      t.references :municipio
      t.integer :ano
      t.decimal :total, :precision => 10, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :presupuestos
  end
end
