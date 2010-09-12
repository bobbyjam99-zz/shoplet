# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  private
  def intern_price
    if params[:product] && params[:product][:price]
      v = params[:product][:prict].split('.').map(&:to_i)
      params[:product][:price] = v[0]*100 + v[1]
    end
  end
end
