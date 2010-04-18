# == Schema Information
# Schema version: 20100418114814
#
# Table name: municipios
#
#  id         :integer         not null, primary key
#  nombre     :string(255)
#  provincia  :string(255)
#  codigo_ine :integer
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#

class Municipio < ActiveRecord::Base
  before_validation :update_or_create_slug

  has_many :presupuestos
  has_many :demograficas

  validates_uniqueness_of :slug
  
  def province_name
    PROVINCES[provincia]
  end      
  def demographics_for(year)
    demograficas.for_year(year).first
  end
  def budget_for(year)
    presupuestos.for_year(year).first
  end
  def self.search(query, options)                                        
    Municipio.find(:all, options.merge(:conditions => ['nombre LIKE ?', "%#{query}%"]))
  end

  def to_param
    self.slug
  end  

  private
  def update_or_create_slug
    if self.new_record? || self.nombre_changed? || self.slug.blank?
      self.slug = self.nombre.parameterize.to_s
    end
  end
end

