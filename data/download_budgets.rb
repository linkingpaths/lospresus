require 'net/http'

# download budgets
# http://cooplocal.mpt.es/cgi-bin/webapb/webdriver?MIval=presmun_fichero&anualidad=1985&prov=48

puts "Download budgets"
(1..52).each do |prov|
  print "prov:#{prov}"
  (1985..2010).each do |year|
    begin
      Net::HTTP.start("cooplocal.mpt.es") do |http|
        resp = http.get("/cgi-bin/webapb/webdriver?MIval=presmun_fichero&anualidad=#{year}&prov=#{prov}")
        open("presupuestos/#{prov}-#{year}.csv", "wb") do |file|
          file.write(resp.body)
        end
      end
      print "."
    rescue Exception => e
      print " ERROR:#{year} "
    end
    STDOUT.flush
  end
  puts ""
end