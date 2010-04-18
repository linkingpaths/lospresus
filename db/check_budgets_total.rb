Municipio.all.each do |muni|
  puts "Updating #{muni.nombre}"
  muni.presupuestos.each do |budget|                    
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