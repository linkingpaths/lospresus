require 'fastercsv'

module SupportFunctions
  def self.check_demography
    ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10"].each do |year|
      file = "#{RAILS_ROOT}/data/ine/csv/pobmun#{year}.csv"
      puts "*********************************************************************"
      puts "Processing year '#{year}"
      puts "*********************************************************************"
      FasterCSV.foreach(file, :col_sep => ";") do |row|
        province_id   = row[0]
        province_name = row[1]
        city_id = row[2]
        city_name = row[3]
        demo_total= row[4].gsub(/\./, '')
        demo_man= row[5].gsub(/\./, '')
        demo_woman= row[6].gsub(/\./, '')
        ine_id = (province_id + city_id).to_i
        mun = Municipio.find_by_codigo_ine(ine_id)
        unless mun
          mun = Municipio.create(:nombre => city_name,
                           :provincia =>province_id,
                           :codigo_ine => ine_id)
          puts "Creating #{mun.nombre}"
        end
        y = "20#{year}".to_i
        demos = mun.demograficas.find_by_ano(y)
        unless demos
          puts "Creating demographics for #{mun.nombre} [#{y}]"
          mun.demograficas.create(:ano => y,
                                 :total =>demo_total,
                                 :mujeres =>demo_woman,
                                 :hombres =>demo_man)
        else
          puts "Updating demographics for #{mun.nombre} [#{y}]"
          demos.total = demo_total
          demos.mujeres = demo_woman
          demos.hombres = demo_man
          demos.save!
        end
      end
    end
  end

  def self.check_city_slugs
    munis = Municipio.all

    munis.each_with_index do |muni, idx|
      clashing = Municipio.find_all_by_nombre(muni.nombre)

      if clashing.size == 1
        puts "Slugized #{muni.nombre} [#{idx}/#{munis.size}]"
        unless muni.slug
          muni.slug = muni.nombre.parameterize
          muni.save!
        end
      else
        puts "Clashing names found for #{muni.nombre}!"
        clashing.each do |cs|
          unless cs.slug
            cs.slug = (cs.nombre + "-" + cs.province_name).parameterize
            puts "Trying #{cs.id} - #{cs.slug}"
            cs.save!
          end
        end
      end
    end
  end

  def self.check_budgets
    (1..52).each do |prov|
      (1985..Date.today.year).each do |year|
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
  end

  def self.check_budgets_total
    munis = Municipio.all

    munis.each_with_index do |muni, idx|
      puts "Updating #{muni.nombre} [#{idx}/#{munis.size}]"
      muni.presupuestos.each do |budget|
        if budget.total_ingresos == nil || budget.total_gastos == nil
          c1, c2, c3, c4, c5, c6, c7, c8, c9 = budget.chapter(1), budget.chapter(2), budget.chapter(3), budget.chapter(4), budget.chapter(5), budget.chapter(6), budget.chapter(7), budget.chapter(8), budget.chapter(9)
          budget.total_ingresos = c1.ingresos + c2.ingresos + c3.ingresos + c4.ingresos +
                                  c5.ingresos + c6.ingresos + c7.ingresos + c8.ingresos +
                                  c9.ingresos

          budget.total_gastos = c1.gastos + c2.gastos + c3.gastos + c4.gastos +
                                (c5.gastos || 0 ) + c6.gastos + c7.gastos + c8.gastos +
                                c9.gastos
          budget.save
        end
      end
    end
  end
end
