class ChangeTotalInBudgets < ActiveRecord::Migration
  def self.up     
    rename_column :presupuestos, :total, :total_ingresos
    add_column :presupuestos, :total_gastos, :decimal, :precision => 10, :scale => 2

  end

  def self.down
    remove_column :presupuestos, :total_gastos
    rename_column :presupuestos, :total_ingresos, :total
  end
end
