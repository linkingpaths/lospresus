require 'fastercsv'
require 'iconv'

puts "*********************************************************************"
puts " Convert files"
puts "*********************************************************************"

(1..52).each do |p|
  puts ">> PROV #{p}"
  
  prov = "%02d" % p
  file = "#{RAILS_ROOT}/data/ine/1996-1999/#{prov}.csv"

  ["99","98","96"].each_with_index do |year,i|
    puts "   year => #{year}"
    FasterCSV.open("#{RAILS_ROOT}/data/ine/1996-1999/pobmun#{year}.csv", "a", :col_sep => ";") do |csv|
      FasterCSV.foreach(file, :col_sep => ";") do |row|
        row_0 = Iconv.iconv("UTF-8", "iso-8859-1", row[0]).to_s
        
        cod_prov = row_0.split("  ")[0][0..1]
        nom_prov = PROVINCES[cod_prov]
        cod_muni = row_0.split("  ")[0][2..-1]
        nom_muni = row_0.split("  ")[1].gsub(" (Capital)","")
        total    = row[i+1] == ".." ? "" : row[i+1].to_i
        varones  = row[i+4] == ".." ? "" : row[i+4].to_i
        mujeres  = row[i+7] == ".." ? "" : row[i+7].to_i
        
        csv << [cod_prov,nom_prov,cod_muni,nom_muni,total,varones,mujeres]
      end
    end
  end
end
