class AddIndexToTables < ActiveRecord::Migration
  def self.up    
    add_index :presupuestos, :ano
    add_index :demograficas, :ano
    add_index :municipios, :codigo_ine
    
  end

  def self.down         
    remove_index :presupuestos, :ano
    remove_index :demograficas, :ano
    remove_index :municipios, :codigo_ine
    
  end
end
