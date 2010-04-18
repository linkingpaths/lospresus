# == Schema Information
# Schema version: 20100417235855
#
# Table name: presupuestos
#
#  id             :integer         not null, primary key
#  municipio_id   :integer
#  ano            :integer
#  total_ingresos :decimal(, )
#  created_at     :datetime
#  updated_at     :datetime
#  total_gastos   :decimal(10, 2)
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
    chapter(1).ingresos + chapter(2).ingresos + chapter(3).ingresos 
  end
  def income_administrations
    #Otras administraciones = capítulo 4 y 7
    chapter(4).ingresos + chapter(7).ingresos
  end                      
  def income_assets
    #Patrimonio = capítulo 5 y 6
    chapter(5).ingresos + chapter(6).ingresos
    
  end       
  def income_financial
    #Activos financieros = capítulo 8
    chapter(8).ingresos
  end
  def income_loans
    #Préstamos = capítulo 9
    chapter(9).ingresos
  end                                            
  
  
  ########################################        
  # => EXPENSE
  ########################################
  def expense_people
    #Personal = capítulo 1
    chapter(1).gastos
  end      
  
  def expense_commons
    #Gastos cotidianos = capítulo 2
    chapter(2).gastos
  end
  
  def expense_projects
    #Proyectos e inversiones = capítulo 6
    chapter(6).gastos
  end

  def expense_grants
    #Subvenciones = capítulo 4
    chapter(4).gastos
  end

  def expense_administrations
    #Otras administraciones y entidades = capítulo 7 
     chapter(7).gastos
  end
  def expense_financial
    #Activos financieros = capítulo 8
    chapter(8).gastos
  end
  def expense_loans
    #Préstamos y gastos financieros = capítulo 3 y 9  
    chapter(3).gastos + chapter(9).gastos
  end                  
  
  def chapter(i)
    capitulos.number(i).first
  end
  
end
