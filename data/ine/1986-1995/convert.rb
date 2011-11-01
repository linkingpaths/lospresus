require 'fastercsv'
require 'iconv'

#             ;1995     ;1994     ;1993     ;1992     ;1991     ;1990     ;1989     ;1988     ;1987     ;1986     ;1995     ;1994     ;1993     ;1992     ;1991     ;1990     ;1989     ;1988     ;1987     ;1986     ;1995     ;1994     ;1993     ;1992     ;1991     ;1990     ;1989     ;1988     ;1987     ;1986     ;
# 51001  Ceuta;"73142.0";"71926.0";"70777.0";"68343.0";"67615.0";"68970.0";"68014.0";"67188.0";"53239.0";"65151.0";"36486.0";"35705.0";"35024.0";"33583.0";"33193.0";"34136.0";"33568.0";"33132.0";"26493.0";"32010.0";"36656.0";"36221.0";"35753.0";"34760.0";"34422.0";"34834.0";"34446.0";"34056.0";"26746.0";"33141.0";


puts "*********************************************************************"
puts " Convert files"
puts "*********************************************************************"

(1..52).each do |p|
  puts ">> PROV #{p}"
  
  prov = "%02d" % p
  file = "#{RAILS_ROOT}/data/ine/1986-1995/#{prov}.csv"

  ["95","94","93","92","91","90","89","88","87","86"].each_with_index do |year,i|
    puts "   year => #{year}"
    FasterCSV.open("#{RAILS_ROOT}/data/ine/1986-1995/pobmun#{year}.csv", "a", :col_sep => ";") do |csv|
      FasterCSV.foreach(file, :col_sep => ";") do |row|
        row_0 = Iconv.iconv("UTF-8", "iso-8859-1", row[0]).to_s
        
        cod_prov = row_0.split("  ")[0][0..1]
        nom_prov = PROVINCES[cod_prov]
        cod_muni = row_0.split("  ")[0][2..-1]
        nom_muni = row_0.split("  ")[1].gsub(" (Capital)","")
        total    = row[i+1] == ".." ? "" : row[i+1].to_i
        varones  = row[i+11] == ".." ? "" : row[i+11].to_i
        mujeres  = row[i+21] == ".." ? "" : row[i+21].to_i
        
        csv << [cod_prov,nom_prov,cod_muni,nom_muni,total,varones,mujeres]
      end
    end
  end
end
