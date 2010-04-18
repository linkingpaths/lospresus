class AddIndexToPresupuestos < ActiveRecord::Migration
  def self.up        
    add_index :presupuestos, :municipio_id
  end

  def self.down      
    remove_index :presupuestos, :municipio_id
  end
end
