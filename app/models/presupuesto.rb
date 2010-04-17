# == Schema Information
# Schema version: 20100417090855
#
# Table name: presupuestos
#
#  id           :integer         not null, primary key
#  municipio_id :integer
#  ano          :integer
#  total        :decimal(, )
#  created_at   :datetime
#  updated_at   :datetime
#

class Presupuesto < ActiveRecord::Base
  belongs_to :municipio
  has_many :capitulos
end
