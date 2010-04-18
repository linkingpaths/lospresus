ActionController::Routing::Routes.draw do |map|

  map.with_options(:controller => 'municipios') do |muni|
    muni.city_search  '/search', :action => 'search'
    muni.city_card  '/:id', :action => 'show'#, :requirements => { :id => /\S+/ }
    muni.city_evolution  '/:id/evolucion', :action => 'evolution'
    muni.city_card_by_year  '/:id/:year', :action => 'show'
    muni.city_compare  '/:city_a_id/y/:city_b_id', :action => 'compare'
  end

  map.with_options(:controller => 'static') do |static|
    static.about '/quevan', :page => 'about'
  end

  map.root :controller => "home"
end
