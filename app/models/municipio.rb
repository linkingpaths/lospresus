# == Schema Information
# Schema version: 20100417090855
#
# Table name: municipios
#
#  id         :integer         not null, primary key
#  nombre     :string(255)
#  provincia  :string(255)
#  codigo_ine :integer
#  created_at :datetime
#  updated_at :datetime
#

class Municipio < ActiveRecord::Base
  has_many :presupuestos
  has_many :demograficas
  def to_param
    "#{self.id}-#{self.nombre.parameterize}"
  end  
  def province_name
    PROVINCES[provincia]
  end      
  def demographics_for(year)
    demograficas.for_year(year).first
  end
  def budget_for(year)
    presupuestos.for_year(year).first
  end
  def self.search(query)
    Municipio.find(:all, :conditions => ['nombre LIKE ?', "%#{query}%"])
  end
end

