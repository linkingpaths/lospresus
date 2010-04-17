# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

require 'fastercsv'

["00", "01", "02", "03", "04", "05", "06", "07", "08", "09"].each do |year|
  file = "#{RAILS_ROOT}/data/ine/csv/pobmun#{year}.csv"
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

(1..52).each do |prov|
  (1985..2009).each do |year|
    puts "*********************************************************************"
    puts "Processing '#{prov} - #{year}'"
    puts "*********************************************************************"
    FasterCSV.foreach("#{RAILS_ROOT}/data/presupuestos/#{prov}-#{year}.csv", :col_sep =>"\t", :row_sep =>:auto) do |row|
      ine = "#{row[0]}#{"%03d" % row[4].to_i}".to_i
      
      muni = Municipio.find_by_codigo_ine(ine)
      unless muni
        muni = Municipio.create(:codigo_ine => ine, :provincia =>row[1], :nombre =>row[5])
        puts "Creating #{muni.nombre}"
      end
      
      unless muni.presupuestos.find_by_ano(year)
        puts "Creating presu #{muni.nombre} - #{year}"
        presu = muni.presupuestos.build(:ano => year)
        presu.capitulos.build(:capitulo => 1, :ingresos=>row[6], :gastos =>row[16])
        presu.capitulos.build(:capitulo => 2, :ingresos=>row[7], :gastos =>row[17])
        presu.capitulos.build(:capitulo => 3, :ingresos=>row[8], :gastos =>row[18])
        presu.capitulos.build(:capitulo => 4, :ingresos=>row[9], :gastos =>row[19])
        presu.capitulos.build(:capitulo => 5, :ingresos=>row[10])
        presu.capitulos.build(:capitulo => 6, :ingresos=>row[11], :gastos =>row[20])
        presu.capitulos.build(:capitulo => 7, :ingresos=>row[12], :gastos =>row[21])
        presu.capitulos.build(:capitulo => 8, :ingresos=>row[13], :gastos =>row[22])
        presu.capitulos.build(:capitulo => 9, :ingresos=>row[14], :gastos =>row[23])
        presu.save!
      end
    end if File.exist?("#{RAILS_ROOT}/data/presupuestos/#{prov}-#{year}.csv")
  end
end
