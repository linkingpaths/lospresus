# == Schema Information
# Schema version: 20100417235855
#
# Table name: capitulos
#
#  id             :integer         not null, primary key
#  presupuesto_id :integer
#  capitulo       :integer
#  ingresos       :decimal(10, 2)
#  gastos         :decimal(10, 2)
#  created_at     :datetime
#  updated_at     :datetime
#

class Capitulo < ActiveRecord::Base
  belongs_to :presupuesto
  
  named_scope :number, lambda { |i|
    { :conditions => { :capitulo => i }, :limit => 1 }
  }           
  def i
    ingresos || 0
  end
  def g
    gastos || 0
  end
end
