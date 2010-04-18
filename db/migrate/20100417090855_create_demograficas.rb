class CreateDemograficas < ActiveRecord::Migration
  def self.up
    create_table :demograficas do |t|
      t.references :municipio
      t.integer :ano
      t.integer :total
      t.integer :mujeres
      t.integer :hombres

      t.timestamps
    end
  end

  def self.down
    drop_table :demograficas
  end
end
