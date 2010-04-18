class ChangeTotalCols < ActiveRecord::Migration
  def self.up
    change_column(:presupuestos, :total_ingresos, :decimal, :precision => 12, :scale => 2)
    change_column(:presupuestos, :total_gastos, :decimal, :precision => 12, :scale => 2)
    change_column(:capitulos, :ingresos, :decimal, :precision => 12, :scale => 2)
    change_column(:capitulos, :gastos, :decimal, :precision => 12, :scale => 2)
  end

  def self.down
    change_column(:presupuestos, :total_ingresos, :decimal, :precision => 10, :scale => 2)
    change_column(:presupuestos, :total_gastos, :decimal, :precision => 10, :scale => 2)
    change_column(:capitulos, :ingresos, :decimal, :precision => 10, :scale => 2)
    change_column(:capitulos, :gastos, :decimal, :precision => 10, :scale => 2)
  end
end
