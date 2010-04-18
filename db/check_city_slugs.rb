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