# == Schema Information
# Schema version: 20100417235855
#
# Table name: presupuestos
#
#  id             :integer         not null, primary key
#  municipio_id   :integer
#  ano            :integer
#  total_i :decimal(, )
#  created_at     :datetime
#  updated_at     :datetime
#  total_g   :decimal(10, 2)
#

class Presupuesto < ActiveRecord::Base
  belongs_to :municipio
  has_many :capitulos    
  
  named_scope :for_year, lambda { |y|
    { :conditions => { :ano => y }, :limit => 1 }
  }           

  ########################################        
  # => INCOME
  ########################################
  def income_taxes
    #Impuestos y tasas = capítulo 1, 2, 3
    chapter(1).i + chapter(2).i + chapter(3).i 
  end
  def income_administrations
    #Otras administraciones = capítulo 4 y 7
    chapter(4).i + chapter(7).i
  end                      
  def income_assets
    #Patrimonio = capítulo 5 y 6
    chapter(5).i + chapter(6).i
    
  end       
  def income_financial
    #Activos financieros = capítulo 8
    chapter(8).i
  end
  def income_loans
    #Préstamos = capítulo 9
    chapter(9).i
  end                                            
  
  
  ########################################        
  # => EXPENSE
  ########################################
  def expense_people
    #Personal = capítulo 1
    chapter(1).g
  end      
  
  def expense_commons
    #g cotidianos = capítulo 2
    chapter(2).g
  end
  
  def expense_projects
    #Proyectos e inversiones = capítulo 6
    chapter(6).g
  end

  def expense_grants
    #Subvenciones = capítulo 4
    chapter(4).g
  end

  def expense_administrations
    #Otras administraciones y entidades = capítulo 7 
     chapter(7).g
  end
  def expense_financial
    #Activos financieros = capítulo 8
    chapter(8).g
  end
  def expense_loans
    #Préstamos y g financieros = capítulo 3 y 9  
    chapter(3).g + chapter(9).g
  end                  
  
  def chapter(i)
    capitulos.number(i).first
  end
  
end
