# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def money(amount)
    number_to_currency(amount, :unit => "€", :delimiter => ".", :precision => 0, :format => "%n%u")
  end
  def people(amount)
    number_with_delimiter(amount, :delimiter => ".")
  end
end
