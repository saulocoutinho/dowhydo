#require "application_responder"

class ApplicationController < ActionController::Base
  #self.responder = ApplicationResponder
  #respond_to :html, :jsonp


  protect_from_forgery
  
  before_filter :authenticate_user!

  before_filter :cors_set_access_control_headers
  
  #check_authorization

  private
  # For all responses in this controller, return the CORS access control headers.
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end
  
end
