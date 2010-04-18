class Province
  
  def self.incomes_average(p, year)
    munis = Municipio.find_all_by_provincia(p)
    bs = munis.collect{|m| m.budget_for(year)}
    bs.compact.sum{|b| b.total_ingresos} / bs.size
  end
  def self.expense_average(p, year)
    munis = Municipio.find_all_by_provincia(p)
    bs = munis.collect{|m| m.budget_for(year)}
    bs.compact.sum{|b| b.total_gastos} / bs.size
  end
end