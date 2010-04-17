# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

require 'fastercsv'

["00", "01", "02", "03", "04", "05", "06", "07", "08", "09"].each do |year|
  file = "#{RAILS_ROOT}/ine/csv/pobmun#{year}.csv"
  puts "*********************************************************************"
  puts "Processing year '#{year}"
  puts "*********************************************************************"
  FasterCSV.foreach(file, :col_sep => ";") do |row|
    province_id      = row[0]
    province_name = row[1]
    city_id = row[2]
    city_name = row[3]
    demo_total= row[4]
    demo_man= row[5]
    demo_woman= row[6]
    ine_id = (province_id + city_id).to_i
    mun = Municipio.find_by_codigo_ine(ine_id)
    unless mun
      mun = Municipio.create(:nombre => city_name,
                       :provincia =>province_id,
                       :codigo_ine => ine_id)
      puts "Creating #{mun.nombre}"
    end                           
    y = "20#{year}".to_i
    unless mun.demograficas.find_by_ano(y)
      puts "Updating demographics for #{mun.nombre} [#{y}]"
      mun.demograficas.create(:ano => y,
                             :total =>demo_total,
                             :mujeres =>demo_woman,
                             :hombres =>demo_man)
    end
  end
end
