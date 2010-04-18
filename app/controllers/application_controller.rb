# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  filter_parameter_logging :password
  
  #rescue_from ActionView::TemplateError do render :template => 'errors/404' end
  #rescue_from ActionController::RoutingError do render :template => 'errors/404' end
  
end
