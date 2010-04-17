class CreateMunicipios < ActiveRecord::Migration
  def self.up
    create_table :municipios do |t|
      t.string :nombre
      t.string :provincia
      t.integer :codigo_ine

      t.timestamps
    end
  end

  def self.down
    drop_table :municipios
  end
end
