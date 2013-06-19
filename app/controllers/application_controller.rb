require 'api_methods'

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!#, :check_api_connection

  private

  def check_api_connection
    if current_user
      api = ApiMethods.new
      unless api.checkCookieValid(session)
        if !session["api_server"].nil? && !session["api_userid"].nil? && !session["api_password"].nil?
          api.login(session, session["api_server"], session["api_userid"], session["api_password"])
        else
          sign_out
          redirect_to new_user_session_path
        end
      end
    end
  end

end
