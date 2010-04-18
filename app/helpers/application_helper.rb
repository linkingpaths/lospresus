# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def money(amount)
    number_to_currency(amount, :unit => "€", :delimiter => ".", :precision => 0, :format => "%n%u")
  end
  def people(amount)
    number_with_delimiter(amount, :delimiter => ".")
  end    
  def income_gap(muni, year)
    local = muni.budget_for(year).total_ingresos 
    provincial = Province.incomes_average(muni.provincia,year)  
    gap = number_with_precision(((local * 100)/provincial)-100, :precision => 0)
    local > provincial ? "+#{gap}" : "#{gap}"
  end                       
  def expense_gap(muni, year)
    local = muni.budget_for(year).total_gastos 
    provincial = Province.expense_average(muni.provincia,year)  
    gap = number_with_precision(((local * 100)/provincial)-100, :precision => 0)
    local > provincial ? "+#{gap}" : "#{gap}"
  end                       
end
