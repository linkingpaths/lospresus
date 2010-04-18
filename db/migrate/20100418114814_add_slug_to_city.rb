class AddSlugToCity < ActiveRecord::Migration
  def self.up
    add_column :municipios, :slug, :string
  end

  def self.down
    remove_column :municipios, :slug
  end
end
