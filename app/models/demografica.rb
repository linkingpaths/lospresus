# == Schema Information
# Schema version: 20100417090855
#
# Table name: demograficas
#
#  id           :integer         not null, primary key
#  municipio_id :integer
#  ano          :integer
#  total        :integer
#  mujeres      :integer
#  hombres      :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Demografica < ActiveRecord::Base
  belongs_to :municipio
end
