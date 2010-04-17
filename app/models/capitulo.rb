# == Schema Information
# Schema version: 20100417090855
#
# Table name: capitulos
#
#  id             :integer         not null, primary key
#  presupuesto_id :integer
#  capitulo       :integer
#  ingresos       :decimal(, )
#  gastos         :decimal(, )
#  created_at     :datetime
#  updated_at     :datetime
#

class Capitulo < ActiveRecord::Base
  belongs_to :presupuesto
end
