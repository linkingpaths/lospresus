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
end
