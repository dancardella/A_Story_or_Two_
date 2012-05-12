class ApplicationController < ActionController::Base
  protect_from_forgery

  def timestamp(user)
      user.timestamp=Time.now 
  end

include SessionsHelper
end
