class AddIndexesToChapters < ActiveRecord::Migration
  def self.up 
    add_index :capitulos, [:presupuesto_id, :capitulo]
    
  end

  def self.down
    remove_index :capitulos, [:presupuesto_id, :capitulo]
  end
end
