# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def money(amount)
    number_to_currency(amount, :unit => "€", :delimiter => ".", :precision => 0, :format => "%n%u")
  end
end
