# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  filter_parameter_logging :password
  
  meta  :title        => "lospresus.de - Las cuentas claras y el chocolate espeso -  Presupuesto municipales de España para humanos",
        :description  => "lospresus.de es un sitio web con el que queremos analizar los ingresos y gastos municipales de todos los municipios de España basándonos en sus presupuestos oficiales. Estos presupuestos oficiales los obtenemos del Ministerio de Política Territorial.",
        :keywords     => "presupuestos, ayuntamientos, gastos, ingresos, subvenciones, municipios, municipal, dinero público, gasto público"
        
        
  #rescue_from ActionView::TemplateError do render :template => 'errors/404' end
  #rescue_from ActionController::RoutingError do render :template => 'errors/404' end
  
end
