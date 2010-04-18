ActionController::Routing::Routes.draw do |map|

  map.connect '', :controller => "home"

  map.with_options(:controller => 'static', :action => 'show') do |static|
    static.about '/quevan', :page => 'about'
  end
  
  map.with_options(:controller => 'municipios') do |muni|
    muni.city_search  '/search', :action => 'search'
    muni.cities_by_query  '/municipios', :action => 'cities_by_query'
    muni.city_card  '/:id', :action => 'show'
    muni.city_search_for_compare  '/:id/search_for_compare', :action => 'search_for_compare'
    muni.cities_to_compare_by_query  '/:id/comparar_con', :action => 'cities_to_compare_by_query'
    muni.city_evolution  '/:id/evolucion', :action => 'evolution'
    muni.city_compare  '/:id/y/:b_id', :action => 'compare'
    muni.city_card_by_year  '/:id/:year', :action => 'show'
  end


  map.root :controller => "home"
end
